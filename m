Received: from eggs.gnu.org ([2001:4830:134:3::10]:54678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvsQb-00071n-Mo
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvsQX-00044V-Lm
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvsQX-00044B-Fa
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:25:17 -0400
Date: Wed, 5 Apr 2017 18:25:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170405212512.GB15566@thinpad.lan.raisama.net>
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

Forgot to answer this part on my previous message:

On Wed, Apr 05, 2017 at 10:01:29PM +0300, Marcel Apfelbaum wrote:
[...]
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

It's true that q35 wouldn't break if it simply used
user_creatable after applying this series. But it will break if
one day we link code that registers a user-creatable non-x86
device inside the qemu-system-x86_64 binary (even if by
accident), or if we add a new user-creatable sysbus device for
other x86 machines (e.g. isapc, xenfv, xenpv, pc-i440fx).

Maybe those situations are unlikely, but if we introduce common
infrastructure to let machine-types define their sysbus
whitelists[1], we get the ability to define the q35 whitelist for
free.

[1] See "[RFC 0/4] Replace has_dynamic_sysbus with device type whitelist"

-- 
Eduardo
