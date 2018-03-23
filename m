Received: from eggs.gnu.org ([2001:4830:134:3::10]:52380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezTsb-0006g8-7m
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ezTsW-0000GG-8n
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ezTsW-0000Em-0b
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:05:36 -0400
Date: Fri, 23 Mar 2018 18:05:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180323210532.GD28161@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520860275-101576-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/9] cli: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, Mar 12, 2018 at 02:11:09PM +0100, Igor Mammedov wrote:
> This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
> allowing the configuration of QEMU from QMP before the machine jumps
> into board initialization code of machine_run_board_init()
> 
> Intent is to allow management to query machine state and additionally
> configure it using previous query results within one QEMU instance
> (i.e. eliminate need to start QEMU twice, 1st to query board specific
> parameters and 2nd for actual VM start using query results for
> additional parameters).
> 
> New option complements -S option and could be used with or without
> it. Difference is that -S pauses QEMU when machine is completely
> build with all devices wired up and ready run (QEMU need only to
> unpause CPUs to let guest execute its code).
> And "preconfig" option pauses QEMU early before board specific init
> callback (machine_run_board_init) is executed and will allow to
> configure machine parameters which will be used by board init code.
> 
> When early introspection/configuration is done, command 'cont' should
> be used to exit RUN_STATE_PRECONFIG and transition to the next
> requested state (i.e. if -S is used then QEMU will pause the second
> time when board/device initialization is completed or start guest
> execution if -S isn't provided on CLI)
> 
> PS:
> Initially 'preconfig' is planned to be used for configuring numa
> topology depending on board specified possible cpus layout.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

TL;DR: I was against this approach of adding a new "preconfig"
state and thought "-S" ought to be enough, but I'm now convinced
this is the best option we have.


Long version:

So, I was skeptical of this approach initially, because I thought
"machine->init() was run" and "machine->init() was not run yet"
is supposed to be internal QEMU state that no external component
should care about at all, because the vCPUs are not running yet.

In other words, if vCPUS were not started yet, we should be able
to reconfigure anything, and "-S" ought to be enough to what we
want.

...in theory.  In practice this is messy:

Currently initialization works this way:

  void vm_start()  /* this is delayed if -S is used */
  {
      resume_all_vcpus();
  }

  void qmp_cont()  /* "cont" command */
  {
      /* ... */
      vm_start();
  }
  
  void main()
  {
      /* ... */
      machine_run_board_init()
      if (autostart) {  /* -S option sets autotstart = 0 */
          vm_start();
      }
      main_loop();  /* QMP becomes available here */
  }

Then we would have to either do this:

  void vm_start()
  {
      machine_run_board_init()  /* <---- HERE */
      resume_all_vcpus();
  }

  void main()
  {
      /* ... */
      /* machine_run_board_init() moved from here */
      if (autostart) {
          vm_start();
      }
      main_loop();
  }

...and fix every single QMP command to not break if
machine_run_board_init() wasn't called yet.

I don't think that's feasible.


Or we could do this:

  void vm_start()
  {
      configure_numa()  /* <---- HERE */
      resume_all_vcpus();
  }

  void main()
  {
      /* ... */
      machine_run_board_init();
      if (autostart) {
          vm_start();
      }
      main_loop();
  }

...and slowly move code from machine_run_board_init() to
vm_start() (like configure_numa() above).

That's how I expected us to implement the NUMA QMP configuration
stuff.

But, really, the data and ordering dependencies we have in
machine initialization is insane, and simply moving
configure_numa() after machine_run_board_init() would require
moving almost all of machine_run_board_init() inside vm_start().

In practice this would be more complex than moving
machine_run_board_init() completely inside vm_start().  I don't
think that's feasible.

So I'm OK with your approach.

Now I will review the actual code in a separate e-mail.  :)

-- 
Eduardo
