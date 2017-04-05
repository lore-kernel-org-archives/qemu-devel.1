Received: from eggs.gnu.org ([2001:4830:134:3::10]:59108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvqoz-0001bd-Qn
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvqow-0005DM-MO
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvqow-0005D6-E5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:42:22 -0400
Date: Wed, 5 Apr 2017 16:42:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170405194216.GA15566@thinpad.lan.raisama.net>
References: <20170404202429.14643-1-ehabkost@redhat.com>
	<20170404202429.14643-2-ehabkost@redhat.com>
	<9ae31b10-0f8c-69fc-c53b-089f89beda3e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae31b10-0f8c-69fc-c53b-089f89beda3e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/21] qdev: Replace
 cannot_instantiate_with_device_add_yet with !user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Apr 05, 2017 at 10:01:29PM +0300, Marcel Apfelbaum wrote:
> On 04/04/2017 11:24 PM, Eduardo Habkost wrote:
> > cannot_instantiate_with_device_add_yet was introduced by commit
> > 837d37167dc446af8a91189108b363c04609e296 to replace no_user. It
> > was supposed to be a temporary measure.
> > 
> 
> 
> Hi Eduardo,
> 
> > When it was introduced, we had 54
> > cannot_instantiate_with_device_add_yet=true lines in the code.
> > Today (3 years later) this number has not shrinked: we now have
> > 57 cannot_instantiate_with_device_add_yet=true lines. I think it
> > is safe to say it is not a temporary measure, and we won't see
> > the flag go away soon.
> > 
> > Instead of a long field name that misleads people to believe it
> > is temporary, replace it a shorter and less misleading field:
> > user_creatable.
> 
> I completely agree with you. I never liked "negation" fields
> and especially the ones ending with "_yet".
> 
> I also don't understand why "user_creatable" can't be used for white-listing *Q35*.
> I do understand that on some archs we need a white-list per board,
> but I don't think x86 needs it.
> 
> > 
> > Except for code comments, changes were generated using the
> > following Coccinelle patch:
> > 
> >   @@
> >   expression DC;
> >   @@
> >   (
> >   -DC->cannot_instantiate_with_device_add_yet = false;
> >   +DC->user_creatable = true;
> 
> Is it necessary? Isn't "creatable = true" the default?

cannot_instantiate_with_device_add_yet is also false by default,
but if there's code explicitly setting it to false somewhere, it
is probably necessary for some reason. The script doesn't care
what's the reason, because this is a 100% mechanical translation
from the old logic to equivalent logic using the new field.

If you are still curious about specific cases: explicit
cannot_instantiate_with_device_add_yet=false/user_creatable=true
is necessary at x86_cpu_common_class_init(), because TYPE_CPU has
cannot_instantiate_with_device_add_yet=true (most CPU types don't
support device_add), but TYPE_X86_CPU sets it back to false
(because x86 supports CPU hotplug).

> 
> >   |
> >   -DC->cannot_instantiate_with_device_add_yet = true;
> >   +DC->user_creatable = false;
> >   )
> > 
> >   @@
> >   typedef ObjectClass;
> >   expression dc;
> >   identifier class, data;
> >   @@
> >    static void device_class_init(ObjectClass *class, void *data)
> >    {
> >    ...
> >    dc->hotpluggable = true;
> >   +dc->user_creatable = true;
> 
> OK... it seems risky :). Is true that "hotpluggable" => creatable,
> but the prev rule should work, right?

Note that this part is only changing device_class_init(), and no
other function. dc->hotpluggable=true appears here by pure
chance: it's just because this is the spot where the new
dc->user_creatable=true line is being added.

This explicit line addition is required because there's no
explicit dc->user_creatable=false line in device_class_init
because QOM objects are always zeroed on creation)

> 
> >    ...
> >    }
> > 
> >   @@
> >   @@
> >    struct DeviceClass {
> >    ...
> >   -bool cannot_instantiate_with_device_add_yet;
> >   +bool user_creatable;
> >    ...
> >   }
> > 
> >   @@
> >   expression DC;
> >   @@
> >   (
> >   -!DC->cannot_instantiate_with_device_add_yet
> >   +DC->user_creatable
> >   |
> >   -DC->cannot_instantiate_with_device_add_yet
> >   +!DC->user_creatable
> >   )
> > 
> 
> Nice script!

Thanks!

-- 
Eduardo
