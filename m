Received: from eggs.gnu.org ([2001:4830:134:3::10]:58146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWffc-0000IA-PA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWffY-0005Kv-NC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gWffY-0005Kd-Gw
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:53:40 -0500
Date: Tue, 11 Dec 2018 10:53:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211105329.GE921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181127135030.1671-2-i.maximets@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Nov 27, 2018 at 04:50:27PM +0300, Ilya Maximets wrote:
> If seals are not supported, memfd_create() will fail.
> Furthermore, there is no way to disable it in this case because
> '.seal' property is not registered.

Isn't the real problem here that memfd_backend_instance_init() has
unconditionally set  "m->seal = true"

Surely, if we don't register the '.seal' property, we should default
that flag to false.

> 
> This issue leads to vhost-user-test failures on RHEL 7.2:
> 
>   qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: \
>                       failed to create memfd: Invalid argument
> 
> and actually breaks the feature on such systems.
> 
> Let's restrict memfd backend to systems with sealing support.

I don't think we need todo that - sealing is optional in the QEMU code,
we simply have it set to the wrong default when sealing is not available.

> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
