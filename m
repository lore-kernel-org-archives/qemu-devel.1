Received: from eggs.gnu.org ([2001:4830:134:3::10]:58002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjoer-0007VB-2L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cjoeo-0007GD-Gb
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:58:13 -0500
Date: Fri, 3 Mar 2017 11:58:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170303145807.GC11509@thinpad.lan.raisama.net>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485868319-16151-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>

On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
> When running with KVM on POWER, we register some CPU types during
> the initialization function of the ppc64 KVM code (which unfortunately
> also can not be done via a type_init() like it is done on x86).

Can you elaborate why it can't be done via type_init()? If the
QOM type hierarchy depends on any runtime data unavailable at
type_init(), we should fix that.


>                                                                 So to
> be able to see these updates in the CPU help text, the code that calls
> list_cpus() has to be run after configure_accelerator(). This move should
> be fine since the "cpu_model" variable is also never used before the call
> to configure_accelerator(), and thus there should not be any unwanted
> side effects in the code before configure_accelerator() if the user
> started QEMU with "-cpu ?" or "-cpu help".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I am not convinced that the output of "-cpu help" and
"-cpu help -machine accel=kvm" should look different. Do you have
an example of what exactly is wrong with the output currently?

I actually believe list_cpus() needs to be called _earlier_, not
later. Otherwise we won't be able to fix this bug:

  $ qemu-system-arm -cpu help
  qemu-system-arm:/usr/local/etc/qemu/qemu.conf:1: No machine specified, and there is no default
  Use -machine help to list supported machines
  $ 

> ---
>  vl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 0b72b12..315c5c3 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4055,11 +4055,6 @@ int main(int argc, char **argv, char **envp)
>          qemu_set_hw_version(machine_class->hw_version);
>      }
>  
> -    if (cpu_model && is_help_option(cpu_model)) {
> -        list_cpus(stdout, &fprintf, cpu_model);
> -        exit(0);
> -    }
> -
>      if (!trace_init_backends()) {
>          exit(1);
>      }
> @@ -4298,6 +4293,11 @@ int main(int argc, char **argv, char **envp)
>  
>      configure_accelerator(current_machine);
>  
> +    if (cpu_model && is_help_option(cpu_model)) {
> +        list_cpus(stdout, &fprintf, cpu_model);
> +        exit(0);
> +    }
> +
>      if (qtest_chrdev) {
>          qtest_init(qtest_chrdev, qtest_log, &error_fatal);
>      }
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
