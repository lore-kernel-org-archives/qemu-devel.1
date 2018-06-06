Received: from eggs.gnu.org ([2001:4830:134:3::10]:52909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQh65-0003DJ-Jp
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 18:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQh62-00073n-Gl
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 18:40:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQh62-00072h-7n
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 18:40:02 -0400
Date: Wed, 6 Jun 2018 19:39:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606223956.GD7451@localhost.localdomain>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528295806-90593-4-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v12 3/4] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Wed, Jun 06, 2018 at 10:36:45AM -0400, Babu Moger wrote:
> Enable TOPOEXT feature on EPYC CPU. This is required to support
> hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> 
> Disable TOPOEXT feature for legacy machines.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Now, I just noticed we have a problem here:

"-machine pc -cpu EPYC -smp 64" works today

This patch makes it stop working, but it shouldn't.

On the other hand, I believe you expect:
* "-machine pc -cpu EPYC -smp 8" to automatically enable topoext.
* "-machine pc -cpu Opteron_G1 -smp 8" to not enable topoext.
* What about "-machine -cpu Opteron_G1 -smp 8,threads=2"?


We also have other requirements, I will try to enumerate all of
them below:

0) "-topoext" explicitly configured (any machine-type):
* Must never enable topoext.

1) "+topoext" explicitly configured (any machine-type):
* Must validate topology and refuse to start if unsupported.

2) Older machine-types:
* Must never enable topoext automatically, even if using "EPYC"
  or "threads=2"

3) "EPYC" CPU model (on new machine-types):
* Should enable topoext automatically, but only if topology is
  supported.
* Must not error out if topology is not supported.
* Should this enable topoext automatically even if threads=1?

4) Other AMD CPU models with "threads=2" (on new machine-types):
* We might want to make this enable topoext automatically, too.
  What do you think?

Is the above description accurate?  Do you agree with these
requirements?

We're trying to use the "topoext" property to cover all cases
above, but it looks like we need at least 2 bits to represent all
possible cases.


Maybe we can represent the cases above with two properties:
"topoext" and "auto-topoext".  Then each case would be
represented by:

0) "-topoext" explicitly configured (any machine-type):
* Will clear TOPOEXT on env->features and set TOPOEXT on
  env->user_features
  (already done today)

1) "+topoext" explicitly configured (any machine-type):
* Will set TOPOEXT on both env->user_features and env->features
  (already done today)

2) Older machine-types:
* Will set auto-topoext=off (can be done on compat_props)
* Will set topoext=off on EPYC CPU model (so TOPOEXT won't be set
  by default on env->features) (can be done on compat_props)

3) "EPYC" CPU model (on new machine-types):
* Will set auto-topoext=on (can be the default for all CPU
  models)
* Will set TOPOEXT on env->features) (can be done on CPU model table)

4) Other AMD CPU models with "threads=2" (on new machine-types):
* Will set auto-topoext=on (can be the default on all CPU models)
* Will keep TOPOEXT disabled on env->features (done on the CPU
  model table)


Then the rules would be:

  if {auto_topoext && TOPOEXT not in env->user_features) {
      if (supported_topology) {
          if (threads > 1)
              set TOPOEXT in env->features
      } else
          unset TOPOEXT in env->features
  }

  if (TOPOEXT in env->features && !supported_topology)
      error;
  }

I think this would fulfill all the requirements above.  Please
help me confirm that.

-- 
Eduardo
