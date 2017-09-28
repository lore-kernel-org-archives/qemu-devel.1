Received: from eggs.gnu.org ([2001:4830:134:3::10]:33557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxV6e-0007mN-Qo
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxV6b-0006bX-2F
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxV6a-0006b3-S9
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:27:40 -0400
Date: Thu, 28 Sep 2017 10:27:30 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170928092730.GE12919@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170928084430.17059-1-berrange@redhat.com>
	<150658880436.78.1818358095772477476@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150658880436.78.1818358095772477476@b58463cdfd5f>
Subject: Re: [Qemu-devel] [PATCH v6 0/6] Initial support for keycodemapdb
 GIT submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org, kraxel@redhat.com, pbonzini@redhat.com

On Thu, Sep 28, 2017 at 01:53:25AM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Type: series
> Subject: [Qemu-devel] [PATCH v6 0/6] Initial support for keycodemapdb GIT submodule
> Message-id: 20170928084430.17059-1-berrange@redhat.com

[snip]

>   GIT     ui/keycodemapdb
>   GEN     config-host.h
>   GEN     x86_64-linux-user/config-devices.mak
>   GEN     qemu-options.def
>   GEN     qmp-commands.h
>   GEN     qapi-types.h
>   GEN     qapi-visit.h
>   GEN     qapi-event.h
>   GEN     qmp-marshal.c
>   GEN     qapi-types.c
>   GEN     qapi-visit.c
>   GEN     qapi-event.c
>   GEN     qmp-introspect.h
>   GEN     qmp-introspect.c
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
> make: *** No rule to make target 'ui/input-keymap-linux-to-qcode.c', needed by 'Makefile'.  Stop.
> make: *** Waiting for unfinished jobs....


What's happened here is that the 'GIT ui/keycodemapdb' checout has not
completed by the time it tries to buil ui/input-keymap-linux-to-qcode.c

Makefile depends on 'git-submodule-update', and Makefile also depends
on $(GENERATED_FILES). IOW the checkout of the git submodules is not
serialized wrt generation of files that use the submodule, and the
patchew test had high enough parallelization to show this flaw, which
my local & Travis tests did not see.

So I need to tweak the deps a little...

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
