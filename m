Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E7C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4D220661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4HIkKDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4D220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXfG-0004dp-P1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyXec-0004Ae-1h
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyXea-0003Be-5r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:04:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyXea-0003A2-0z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580720663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2nlnyb9M/cQPfNngS/yX3DXgvPe5jm+Z8q6Itkk+/8=;
 b=H4HIkKDddzw6tmhIfoyfBj/y63Zdrv8s8sVPbXeJ5qfUdEvN5XoH+31yo2HGW5iVCNMirT
 JlXG4JyduE2UwejacFB5EI7HQ2hXV661YOfvpXCimx0qGibDHvy6spMaO2AXK/PMXcskhJ
 6MfV6oIVIyq2WCAGAmhMxfkjO185plI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-M46l1N-0Nw2OKvX3nN5oZg-1; Mon, 03 Feb 2020 04:04:21 -0500
Received: by mail-qt1-f198.google.com with SMTP id d9so9488421qtq.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VAxLpU8vY4sszduIEmbVpIY8M2z95ngMeg4cT120aGk=;
 b=jx6SkyLEwAoZy9A7nl6INvT0cgDh4haLOJPCKvhzjVosomspTLI1nzRRKmffhZuL3Y
 c+HxZ20Z2hGkNtNIAlxA4v77yxOwHXxyq5uyQlVyBra9DVGL7s/h2/s8gVZCtKzKbesb
 ZgHiSvfiBxZX8zDpVcAnAvKTEdocYy0XKfdBF9mCZrV8mK0k6bACWgur+o3WOissyh4H
 DojRgKAvTHtah3K11AD8mK0q3dqQKxML6PsQ0phX5enw8JU/ELb5I7DzmbqIwV0cZvL3
 99arN8ABGyEf5KqU9Em7nRSip4EMBb0/OFRe6z/cirLKLkOT0/qbDGDqSBu1LzA2itSK
 a4mw==
X-Gm-Message-State: APjAAAXeteML2Ve00xegh/lZ9tvR8jeVc9iK+o7S8fqCgRPJCQVh0/Pt
 CWMr9tM3AeGznchwM75j87GHIdUuYDicHjXPV5BXbLujOqFD8We9umtQYmcxAD0sSLwnZ6Ekews
 rp27TYfCM4RQIYa4=
X-Received: by 2002:ac8:36ab:: with SMTP id a40mr22284764qtc.60.1580720660988; 
 Mon, 03 Feb 2020 01:04:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2TXjRHFLIxA0HqwaTmBNpvBuLH3xzunfzdW1168aykxU6YQgV7J2QfmrYQqQ3xGbVBCNAlA==
X-Received: by 2002:ac8:36ab:: with SMTP id a40mr22284749qtc.60.1580720660712; 
 Mon, 03 Feb 2020 01:04:20 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id y27sm9858543qta.50.2020.02.03.01.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:04:19 -0800 (PST)
Date: Mon, 3 Feb 2020 04:04:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 03/80] machine: alias -mem-path and -mem-prealloc into
 memory-foo backend
Message-ID: <20200203040204-mutt-send-email-mst@kernel.org>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1580483390-131164-4-git-send-email-imammedo@redhat.com>
X-MC-Unique: M46l1N-0Nw2OKvX3nN5oZg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pasic@linux.ibm.com, pbonzini@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 04:08:33PM +0100, Igor Mammedov wrote:
> Allow machine to opt in for hostmem backend based initial RAM
> even if user uses old -mem-path/prealloc options by providing
>   MachineClass::default_ram_id
> Follow up patches will incrementally convert machines to new API,
> by dropping memory_region_allocate_system_memory() and setting
> default_ram_id that board used to use before conversion to keep
> migration stream the same.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

What about non-versioned machines though?
Why do these need to set default_ram_id?
Seems redundant as they don't need to support cross-version
migration ...


> ---
> v3:
>    * rename "ram-memdev" property to "memory-backend"
>      (Paolo Bonzini <pbonzini@redhat.com>)
> v4:
>    * previous patch changed memory-backend property from link
>      to string to allow for delayed backend creation, when
>      backend comes explicitly from CLI.
>      So s/object_property_set_link()/object_property_set_str()/
>      to account for that.
>=20
> CC: ehabkost@redhat.com
> CC: pbonzini@redhat.com
> CC: philmd@redhat.com
> CC: pasic@linux.ibm.com
> ---
>  include/hw/boards.h      |  5 +++++
>  include/sysemu/hostmem.h | 16 ++++++++++++++++
>  backends/hostmem-file.c  |  7 -------
>  backends/hostmem-ram.c   |  2 --
>  vl.c                     | 25 +++++++++++++++++++++++++
>  5 files changed, 46 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 7b4b6b7..106de87 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -170,6 +170,10 @@ typedef struct {
>   *    false is returned, an error must be set to show the reason of
>   *    the rejection.  If the hook is not provided, all hotplug will be
>   *    allowed.
> + * @default_ram_id:
> + *    Specifies inital RAM MemoryRegion name to be used for default back=
end
> + *    creation if user explicitly hasn't specified backend with "memory-=
backend"
> + *    property.
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -226,6 +230,7 @@ struct MachineClass {
>      bool nvdimm_supported;
>      bool numa_mem_supported;
>      bool auto_enable_numa;
> +    const char *default_ram_id;
> =20
>      HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>                                             DeviceState *dev);
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 4dbdadd..5db0d66 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -27,6 +27,22 @@
>  #define MEMORY_BACKEND_CLASS(klass) \
>      OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACK=
END)
> =20
> +/* hostmem-ram.c */
> +/**
> + * @TYPE_MEMORY_BACKEND_RAM:
> + * name of backend that uses mmap on the anonymous RAM
> + */
> +
> +#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> +
> +/* hostmem-file.c */
> +/**
> + * @TYPE_MEMORY_BACKEND_FILE:
> + * name of backend that uses mmap on a file descriptor
> + */
> +#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
> +
> +typedef struct HostMemoryBackend HostMemoryBackend;
>  typedef struct HostMemoryBackendClass HostMemoryBackendClass;
> =20
>  /**
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index be64020..cb319a9 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -18,13 +18,6 @@
>  #include "sysemu/sysemu.h"
>  #include "qom/object_interfaces.h"
> =20
> -/* hostmem-file.c */
> -/**
> - * @TYPE_MEMORY_BACKEND_FILE:
> - * name of backend that uses mmap on a file descriptor
> - */
> -#define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
> -
>  #define MEMORY_BACKEND_FILE(obj) \
>      OBJECT_CHECK(HostMemoryBackendFile, (obj), TYPE_MEMORY_BACKEND_FILE)
> =20
> diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
> index 6aab8d3..5cc53e7 100644
> --- a/backends/hostmem-ram.c
> +++ b/backends/hostmem-ram.c
> @@ -16,8 +16,6 @@
>  #include "qemu/module.h"
>  #include "qom/object_interfaces.h"
> =20
> -#define TYPE_MEMORY_BACKEND_RAM "memory-backend-ram"
> -
>  static void
>  ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>  {
> diff --git a/vl.c b/vl.c
> index 24951b5..2367cb6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -75,6 +75,7 @@ int main(int argc, char **argv)
>  #include "ui/input.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/hostmem.h"
>  #include "exec/gdbstub.h"
>  #include "qemu/timer.h"
>  #include "chardev/char.h"
> @@ -2839,6 +2840,26 @@ static void configure_accelerators(const char *pro=
gname)
>      }
>  }
> =20
> +static void create_default_memdev(MachineState *ms, const char *path,
> +                                  bool prealloc)
> +{
> +    Object *obj;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> +
> +    obj =3D object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BAC=
KEND_RAM);
> +    if (path) {
> +        object_property_set_str(obj, path, "mem-path", &error_fatal);
> +    }
> +    object_property_set_bool(obj, prealloc, "prealloc", &error_fatal);
> +    object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
> +    object_property_add_child(object_get_objects_root(), mc->default_ram=
_id,
> +                              obj, &error_fatal);
> +    user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
> +    object_unref(obj);
> +    object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-back=
end",
> +                            &error_fatal);
> +}
> +
>  int main(int argc, char **argv, char **envp)
>  {
>      int i;
> @@ -4302,6 +4323,10 @@ int main(int argc, char **argv, char **envp)
>      }
>      parse_numa_opts(current_machine);
> =20
> +    if (machine_class->default_ram_id && current_machine->ram_size &&
> +        !current_machine->ram_memdev_id) {
> +        create_default_memdev(current_machine, mem_path, mem_prealloc);
> +    }
>      /* do monitor/qmp handling at preconfig state if requested */
>      main_loop();

So this check for default_ram_id will become redundant after the
patchset is fully applied, this is just for bisect to work well, right?
I couldn't find patches that drop this check though.


> --=20
> 2.7.4
>=20
>=20


