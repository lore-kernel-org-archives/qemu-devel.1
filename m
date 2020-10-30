Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC22C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E9622282
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbC275zP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E9622282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYS1t-0001KV-Tz
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRyw-0007rc-N3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRys-00016A-Oz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604055001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lsmkoBhr276ZkEWHY99JVCobtKmrU7woRh1XSC2mEP8=;
 b=PbC275zPEyKITsoytxHrrA3kAudjN6jdYMTGtN10K8xXIn1fot5XQUuElUAI1QV8yMXMSK
 UNTiMMUTF3KkjEDLZrT3/Hy9qRAc1Oylij61iXmeT5nUZWbLs349WeHvdTvABAhxlBqEoO
 1mG9uuRelorZZG3HhC8S1sdgwpdpeyY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-mFImSXR5OuWt57hitOScQg-1; Fri, 30 Oct 2020 06:49:59 -0400
X-MC-Unique: mFImSXR5OuWt57hitOScQg-1
Received: by mail-wr1-f71.google.com with SMTP id v5so2532315wrr.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qltlba2bw1rM/RV3UJywBFYyyWh8XD0lslpxOYomJSg=;
 b=RzGm1GFrPXreOPAl9z86DKdrF8UdiqhUlm+0Gr3qvftZi6HXA70aYjuGuoxz64eFuE
 Rl3qML+kzALDzjBYCK86/7H23y451wqU4mOlPBiMA3N3FgsID79iXf8O03iEbN1DoRmO
 +iUyKmdkyv95b/puaiUbmCwjCe7Ev2zIggwWu+yQ0CkypoAYC4u1Yv1VBRKkbxJlX5UF
 PG0Y0CVWuOJvjj54h/1XFX+WtWiCQ1hAhfFJNmYk8kb6FyifDcjojG1ZVIwEPmTJ6/bi
 SO1JfMPcoSylOk1oNrjVSia5MgL+f3YZ5hdOL7nTIoYn+nfazIX/PNbQWMQeAyev2woz
 QGhg==
X-Gm-Message-State: AOAM532EdyHFrAQRwSne+R+Mvk4PfLzH/R7s2lqmwFbhaYVdGwIUaQ4Y
 C4Ys9jni787aS1aNwuWuJQQsus1Cc6ID1q6JsU8jA+gDTk3l9ZojLKijBzlCIy7+MzdgEeYYHPH
 s39I1uh2R1W2K/uQ=
X-Received: by 2002:a5d:4612:: with SMTP id t18mr2294774wrq.307.1604054997618; 
 Fri, 30 Oct 2020 03:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsOz79z0QnqPEpz9juRvjs87j8ej2apzOOGv/u/DuxvdHDBOatdTIR0xzs29FRPLSegrL++A==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr2294713wrq.307.1604054997150; 
 Fri, 30 Oct 2020 03:49:57 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id g5sm4040077wmi.4.2020.10.30.03.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:49:56 -0700 (PDT)
Date: Fri, 30 Oct 2020 06:49:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v2 2/5] memory: Add IOMMUTLBEvent
Message-ID: <20201030064912-mutt-send-email-mst@kernel.org>
References: <20201019104332.22033-1-eperezma@redhat.com>
 <20201019104332.22033-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201019104332.22033-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 12:43:29PM +0200, Eugenio P=C3=A9rez wrote:
> This way we can tell between regular IOMMUTLBEntry (entry of IOMMU
> hardware) and notifications.
>=20
> In the notifications, we set explicitly if it is a MAPs or an UNMAP,
> instead of trusting in entry permissions to differentiate them.
>=20
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Breaks s390:

FAILED: libqemu-s390x-softmmu.fa.p/hw_s390x_s390-pci-inst.c.o=20
cc -Ilibqemu-s390x-softmmu.fa.p -I. -I../qemu -Itarget/s390x -I../qemu/targ=
et/s390x -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/spice-1 -I/usr/incl=
ude/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64=
/glib-2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -I/usr/include/l=
ibmount -I/usr/include/blkid -I/usr/include/pixman-1 -I/usr/include/capston=
e -fdiagnostics-color=3Dauto -pipe -Wall -Winvalid-pch -Werror -std=3Dgnu99=
 -O2 -g -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -m64 -mcx16 -D_GNU_SOURCE -=
D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant=
-decls -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -f=
no-common -fwrapv -Wold-style-declaration -Wold-style-definition -Wtype-lim=
its -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty=
-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-missing-i=
nclude-dirs -Wno-shift-negative-value -Wno-psabi -fstack-protector-strong -=
isystem /scm/qemu/linux-headers -isystem linux-headers -iquote /scm/qemu/tc=
g/i386 -iquote . -iquote /scm/qemu -iquote /scm/qemu/accel/tcg -iquote /scm=
/qemu/include -iquote /scm/qemu/disas/libvixl -pthread -fPIC -isystem../qem=
u/linux-headers -isystemlinux-headers -DNEED_CPU_H '-DCONFIG_TARGET=3D"s390=
x-softmmu-config-target.h"' '-DCONFIG_DEVICES=3D"s390x-softmmu-config-devic=
es.h"' -MD -MQ libqemu-s390x-softmmu.fa.p/hw_s390x_s390-pci-inst.c.o -MF li=
bqemu-s390x-softmmu.fa.p/hw_s390x_s390-pci-inst.c.o.d -o libqemu-s390x-soft=
mmu.fa.p/hw_s390x_s390-pci-inst.c.o -c ../qemu/hw/s390x/s390-pci-inst.c
../qemu/hw/s390x/s390-pci-inst.c: In function =E2=80=98s390_pci_update_iotl=
b=E2=80=99:
../qemu/hw/s390x/s390-pci-inst.c:599:61: error: incompatible type for argum=
ent 3 of =E2=80=98memory_region_notify_iommu=E2=80=99
  599 |             memory_region_notify_iommu(&iommu->iommu_mr, 0, notify)=
;
      |                                                             ^~~~~~
      |                                                             |
      |                                                             IOMMUTL=
BEntry
In file included from /scm/qemu/include/exec/cpu-all.h:23,
                 from ../qemu/target/s390x/cpu.h:846,
                 from ../qemu/hw/s390x/s390-pci-inst.c:15:
/scm/qemu/include/exec/memory.h:1324:47: note: expected =E2=80=98IOMMUTLBEv=
ent=E2=80=99 but argument is of type =E2=80=98IOMMUTLBEntry=E2=80=99
 1324 |                                 IOMMUTLBEvent event);
      |                                 ~~~~~~~~~~~~~~^~~~~
../qemu/hw/s390x/s390-pci-inst.c:611:53: error: incompatible type for argum=
ent 3 of =E2=80=98memory_region_notify_iommu=E2=80=99
  611 |     memory_region_notify_iommu(&iommu->iommu_mr, 0, notify);
      |                                                     ^~~~~~
      |                                                     |
      |                                                     IOMMUTLBEntry
In file included from /scm/qemu/include/exec/cpu-all.h:23,
                 from ../qemu/target/s390x/cpu.h:846,
                 from ../qemu/hw/s390x/s390-pci-inst.c:15:
/scm/qemu/include/exec/memory.h:1324:47: note: expected =E2=80=98IOMMUTLBEv=
ent=E2=80=99 but argument is of type =E2=80=98IOMMUTLBEntry=E2=80=99
 1324 |                                 IOMMUTLBEvent event);
      |                                 ~~~~~~~~~~~~~~^~~~~


> ---
>  include/exec/memory.h | 27 +++++++------
>  hw/arm/smmu-common.c  | 13 ++++---
>  hw/arm/smmuv3.c       | 13 ++++---
>  hw/i386/intel_iommu.c | 88 ++++++++++++++++++++++++-------------------
>  hw/misc/tz-mpc.c      | 32 +++++++++-------
>  hw/ppc/spapr_iommu.c  | 15 ++++----
>  softmmu/memory.c      | 20 +++++-----
>  7 files changed, 111 insertions(+), 97 deletions(-)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ac6bca1ba0..ab60870c76 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -101,6 +101,11 @@ struct IOMMUNotifier {
>  };
>  typedef struct IOMMUNotifier IOMMUNotifier;
> =20
> +typedef struct IOMMUTLBEvent {
> +    IOMMUNotifierFlag type;
> +    IOMMUTLBEntry entry;
> +} IOMMUTLBEvent;
> +
>  /* RAM is pre-allocated and passed into qemu_ram_alloc_from_ptr */
>  #define RAM_PREALLOC   (1 << 0)
> =20
> @@ -1280,24 +1285,18 @@ uint64_t memory_region_iommu_get_min_page_size(IO=
MMUMemoryRegion *iommu_mr);
>  /**
>   * memory_region_notify_iommu: notify a change in an IOMMU translation e=
ntry.
>   *
> - * The notification type will be decided by entry.perm bits:
> - *
> - * - For UNMAP (cache invalidation) notifies: set entry.perm to IOMMU_NO=
NE.
> - * - For MAP (newly added entry) notifies: set entry.perm to the
> - *   permission of the page (which is definitely !IOMMU_NONE).
> - *
>   * Note: for any IOMMU implementation, an in-place mapping change
>   * should be notified with an UNMAP followed by a MAP.
>   *
>   * @iommu_mr: the memory region that was changed
>   * @iommu_idx: the IOMMU index for the translation table which has chang=
ed
> - * @entry: the new entry in the IOMMU translation table.  The entry
> - *         replaces all old entries for the same virtual I/O address ran=
ge.
> - *         Deleted entries have .@perm =3D=3D 0.
> + * @event: TLB event with the new entry in the IOMMU translation table.
> + *         The entry replaces all old entries for the same virtual I/O a=
ddress
> + *         range.
>   */
>  void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
>                                  int iommu_idx,
> -                                IOMMUTLBEntry entry);
> +                                IOMMUTLBEvent event);
> =20
>  /**
>   * memory_region_notify_iommu_one: notify a change in an IOMMU translati=
on
> @@ -1307,12 +1306,12 @@ void memory_region_notify_iommu(IOMMUMemoryRegion=
 *iommu_mr,
>   * notifies a specific notifier, not all of them.
>   *
>   * @notifier: the notifier to be notified
> - * @entry: the new entry in the IOMMU translation table.  The entry
> - *         replaces all old entries for the same virtual I/O address ran=
ge.
> - *         Deleted entries have .@perm =3D=3D 0.
> + * @event: TLB event with the new entry in the IOMMU translation table.
> + *         The entry replaces all old entries for the same virtual I/O a=
ddress
> + *         range.
>   */
>  void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> -                              IOMMUTLBEntry *entry);
> +                                    IOMMUTLBEvent *event);
> =20
>  /**
>   * memory_region_register_iommu_notifier: register a notifier for change=
s to
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 88d2c454f0..405d5c5325 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -465,14 +465,15 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint=
32_t sid)
>  /* Unmap the whole notifier's range */
>  static void smmu_unmap_notifier_range(IOMMUNotifier *n)
>  {
> -    IOMMUTLBEntry entry;
> +    IOMMUTLBEvent event;
> =20
> -    entry.target_as =3D &address_space_memory;
> -    entry.iova =3D n->start;
> -    entry.perm =3D IOMMU_NONE;
> -    entry.addr_mask =3D n->end - n->start;
> +    event.type =3D IOMMU_NOTIFIER_UNMAP;
> +    event.entry.target_as =3D &address_space_memory;
> +    event.entry.iova =3D n->start;
> +    event.entry.perm =3D IOMMU_NONE;
> +    event.entry.addr_mask =3D n->end - n->start;
> =20
> -    memory_region_notify_iommu_one(n, &entry);
> +    memory_region_notify_iommu_one(n, &event);
>  }
> =20
>  /* Unmap all notifiers attached to @mr */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0a893ae918..62b0e289ca 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -799,7 +799,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>                                 uint8_t tg, uint64_t num_pages)
>  {
>      SMMUDevice *sdev =3D container_of(mr, SMMUDevice, iommu);
> -    IOMMUTLBEntry entry;
> +    IOMMUTLBEvent event;
>      uint8_t granule =3D tg;
> =20
>      if (!tg) {
> @@ -822,12 +822,13 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *m=
r,
>          granule =3D tt->granule_sz;
>      }
> =20
> -    entry.target_as =3D &address_space_memory;
> -    entry.iova =3D iova;
> -    entry.addr_mask =3D num_pages * (1 << granule) - 1;
> -    entry.perm =3D IOMMU_NONE;
> +    event.type =3D IOMMU_NOTIFIER_UNMAP;
> +    event.entry.target_as =3D &address_space_memory;
> +    event.entry.iova =3D iova;
> +    event.entry.addr_mask =3D num_pages * (1 << granule) - 1;
> +    event.entry.perm =3D IOMMU_NONE;
> =20
> -    memory_region_notify_iommu_one(n, &entry);
> +    memory_region_notify_iommu_one(n, &event);
>  }
> =20
>  /* invalidate an asid/iova range tuple in all mr's */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 56bab589d4..3976161317 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1073,7 +1073,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VT=
DContextEntry *ce,
>      }
>  }
> =20
> -typedef int (*vtd_page_walk_hook)(IOMMUTLBEntry *entry, void *private);
> +typedef int (*vtd_page_walk_hook)(IOMMUTLBEvent *event, void *private);
> =20
>  /**
>   * Constant information used during page walking
> @@ -1094,11 +1094,12 @@ typedef struct {
>      uint16_t domain_id;
>  } vtd_page_walk_info;
> =20
> -static int vtd_page_walk_one(IOMMUTLBEntry *entry, vtd_page_walk_info *i=
nfo)
> +static int vtd_page_walk_one(IOMMUTLBEvent *event, vtd_page_walk_info *i=
nfo)
>  {
>      VTDAddressSpace *as =3D info->as;
>      vtd_page_walk_hook hook_fn =3D info->hook_fn;
>      void *private =3D info->private;
> +    IOMMUTLBEntry *entry =3D &event->entry;
>      DMAMap target =3D {
>          .iova =3D entry->iova,
>          .size =3D entry->addr_mask,
> @@ -1107,7 +1108,7 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry, =
vtd_page_walk_info *info)
>      };
>      DMAMap *mapped =3D iova_tree_find(as->iova_tree, &target);
> =20
> -    if (entry->perm =3D=3D IOMMU_NONE && !info->notify_unmap) {
> +    if (event->type =3D=3D IOMMU_NOTIFIER_UNMAP && !info->notify_unmap) =
{
>          trace_vtd_page_walk_one_skip_unmap(entry->iova, entry->addr_mask=
);
>          return 0;
>      }
> @@ -1115,7 +1116,7 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry, =
vtd_page_walk_info *info)
>      assert(hook_fn);
> =20
>      /* Update local IOVA mapped ranges */
> -    if (entry->perm) {
> +    if (event->type =3D=3D IOMMU_NOTIFIER_MAP) {
>          if (mapped) {
>              /* If it's exactly the same translation, skip */
>              if (!memcmp(mapped, &target, sizeof(target))) {
> @@ -1141,19 +1142,21 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry=
, vtd_page_walk_info *info)
>                  int ret;
> =20
>                  /* Emulate an UNMAP */
> +                event->type =3D IOMMU_NOTIFIER_UNMAP;
>                  entry->perm =3D IOMMU_NONE;
>                  trace_vtd_page_walk_one(info->domain_id,
>                                          entry->iova,
>                                          entry->translated_addr,
>                                          entry->addr_mask,
>                                          entry->perm);
> -                ret =3D hook_fn(entry, private);
> +                ret =3D hook_fn(event, private);
>                  if (ret) {
>                      return ret;
>                  }
>                  /* Drop any existing mapping */
>                  iova_tree_remove(as->iova_tree, &target);
> -                /* Recover the correct permission */
> +                /* Recover the correct type */
> +                event->type =3D IOMMU_NOTIFIER_MAP;
>                  entry->perm =3D cache_perm;
>              }
>          }
> @@ -1170,7 +1173,7 @@ static int vtd_page_walk_one(IOMMUTLBEntry *entry, =
vtd_page_walk_info *info)
>      trace_vtd_page_walk_one(info->domain_id, entry->iova,
>                              entry->translated_addr, entry->addr_mask,
>                              entry->perm);
> -    return hook_fn(entry, private);
> +    return hook_fn(event, private);
>  }
> =20
>  /**
> @@ -1191,7 +1194,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uin=
t64_t start,
>      uint32_t offset;
>      uint64_t slpte;
>      uint64_t subpage_size, subpage_mask;
> -    IOMMUTLBEntry entry;
> +    IOMMUTLBEvent event;
>      uint64_t iova =3D start;
>      uint64_t iova_next;
>      int ret =3D 0;
> @@ -1245,13 +1248,15 @@ static int vtd_page_walk_level(dma_addr_t addr, u=
int64_t start,
>               *
>               * In either case, we send an IOTLB notification down.
>               */
> -            entry.target_as =3D &address_space_memory;
> -            entry.iova =3D iova & subpage_mask;
> -            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> -            entry.addr_mask =3D ~subpage_mask;
> +            event.entry.target_as =3D &address_space_memory;
> +            event.entry.iova =3D iova & subpage_mask;
> +            event.entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> +            event.entry.addr_mask =3D ~subpage_mask;
>              /* NOTE: this is only meaningful if entry_valid =3D=3D true =
*/
> -            entry.translated_addr =3D vtd_get_slpte_addr(slpte, info->aw=
);
> -            ret =3D vtd_page_walk_one(&entry, info);
> +            event.entry.translated_addr =3D vtd_get_slpte_addr(slpte, in=
fo->aw);
> +            event.type =3D event.entry.perm ? IOMMU_NOTIFIER_MAP :
> +                                            IOMMU_NOTIFIER_UNMAP;
> +            ret =3D vtd_page_walk_one(&event, info);
>          }
> =20
>          if (ret < 0) {
> @@ -1430,10 +1435,10 @@ static int vtd_dev_to_context_entry(IntelIOMMUSta=
te *s, uint8_t bus_num,
>      return 0;
>  }
> =20
> -static int vtd_sync_shadow_page_hook(IOMMUTLBEntry *entry,
> +static int vtd_sync_shadow_page_hook(IOMMUTLBEvent *event,
>                                       void *private)
>  {
> -    memory_region_notify_iommu((IOMMUMemoryRegion *)private, 0, *entry);
> +    memory_region_notify_iommu(private, 0, *event);
>      return 0;
>  }
> =20
> @@ -1993,14 +1998,17 @@ static void vtd_iotlb_page_invalidate_notify(Inte=
lIOMMUState *s,
>                   * page tables.  We just deliver the PSI down to
>                   * invalidate caches.
>                   */
> -                IOMMUTLBEntry entry =3D {
> -                    .target_as =3D &address_space_memory,
> -                    .iova =3D addr,
> -                    .translated_addr =3D 0,
> -                    .addr_mask =3D size - 1,
> -                    .perm =3D IOMMU_NONE,
> +                IOMMUTLBEvent event =3D {
> +                    .type =3D IOMMU_NOTIFIER_UNMAP,
> +                    .entry =3D {
> +                        .target_as =3D &address_space_memory,
> +                        .iova =3D addr,
> +                        .translated_addr =3D 0,
> +                        .addr_mask =3D size - 1,
> +                        .perm =3D IOMMU_NONE,
> +                    },
>                  };
> -                memory_region_notify_iommu(&vtd_as->iommu, 0, entry);
> +                memory_region_notify_iommu(&vtd_as->iommu, 0, event);
>              }
>          }
>      }
> @@ -2412,7 +2420,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMM=
UState *s,
>                                            VTDInvDesc *inv_desc)
>  {
>      VTDAddressSpace *vtd_dev_as;
> -    IOMMUTLBEntry entry;
> +    IOMMUTLBEvent event;
>      struct VTDBus *vtd_bus;
>      hwaddr addr;
>      uint64_t sz;
> @@ -2460,12 +2468,13 @@ static bool vtd_process_device_iotlb_desc(IntelIO=
MMUState *s,
>          sz =3D VTD_PAGE_SIZE;
>      }
> =20
> -    entry.target_as =3D &vtd_dev_as->as;
> -    entry.addr_mask =3D sz - 1;
> -    entry.iova =3D addr;
> -    entry.perm =3D IOMMU_NONE;
> -    entry.translated_addr =3D 0;
> -    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, entry);
> +    event.type =3D IOMMU_NOTIFIER_UNMAP;
> +    event.entry.target_as =3D &vtd_dev_as->as;
> +    event.entry.addr_mask =3D sz - 1;
> +    event.entry.iova =3D addr;
> +    event.entry.perm =3D IOMMU_NONE;
> +    event.entry.translated_addr =3D 0;
> +    memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
> =20
>  done:
>      return true;
> @@ -3485,19 +3494,20 @@ static void vtd_address_space_unmap(VTDAddressSpa=
ce *as, IOMMUNotifier *n)
>      size =3D remain =3D end - start + 1;
> =20
>      while (remain >=3D VTD_PAGE_SIZE) {
> -        IOMMUTLBEntry entry;
> +        IOMMUTLBEvent event;
>          uint64_t mask =3D get_naturally_aligned_size(start, remain, s->a=
w_bits);
> =20
>          assert(mask);
> =20
> -        entry.iova =3D start;
> -        entry.addr_mask =3D mask - 1;
> -        entry.target_as =3D &address_space_memory;
> -        entry.perm =3D IOMMU_NONE;
> +        event.type =3D IOMMU_NOTIFIER_UNMAP;
> +        event.entry.iova =3D start;
> +        event.entry.addr_mask =3D mask - 1;
> +        event.entry.target_as =3D &address_space_memory;
> +        event.entry.perm =3D IOMMU_NONE;
>          /* This field is meaningless for unmap */
> -        entry.translated_addr =3D 0;
> +        event.entry.translated_addr =3D 0;
> =20
> -        memory_region_notify_iommu_one(n, &entry);
> +        memory_region_notify_iommu_one(n, &event);
> =20
>          start +=3D mask;
>          remain -=3D mask;
> @@ -3533,9 +3543,9 @@ static void vtd_address_space_refresh_all(IntelIOMM=
UState *s)
>      vtd_switch_address_space_all(s);
>  }
> =20
> -static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
> +static int vtd_replay_hook(IOMMUTLBEvent *event, void *private)
>  {
> -    memory_region_notify_iommu_one((IOMMUNotifier *)private, entry);
> +    memory_region_notify_iommu_one(private, event);
>      return 0;
>  }
> =20
> diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
> index 98f151237f..30481e1c90 100644
> --- a/hw/misc/tz-mpc.c
> +++ b/hw/misc/tz-mpc.c
> @@ -82,8 +82,10 @@ static void tz_mpc_iommu_notify(TZMPC *s, uint32_t lut=
idx,
>      /* Called when the LUT word at lutidx has changed from oldlut to new=
lut;
>       * must call the IOMMU notifiers for the changed blocks.
>       */
> -    IOMMUTLBEntry entry =3D {
> -        .addr_mask =3D s->blocksize - 1,
> +    IOMMUTLBEvent event =3D {
> +        .entry =3D {
> +            .addr_mask =3D s->blocksize - 1,
> +        }
>      };
>      hwaddr addr =3D lutidx * s->blocksize * 32;
>      int i;
> @@ -100,26 +102,28 @@ static void tz_mpc_iommu_notify(TZMPC *s, uint32_t =
lutidx,
>          block_is_ns =3D newlut & (1 << i);
> =20
>          trace_tz_mpc_iommu_notify(addr);
> -        entry.iova =3D addr;
> -        entry.translated_addr =3D addr;
> +        event.entry.iova =3D addr;
> +        event.entry.translated_addr =3D addr;
> =20
> -        entry.perm =3D IOMMU_NONE;
> -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
> -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
> +        event.type =3D IOMMU_NOTIFIER_UNMAP;
> +        event.entry.perm =3D IOMMU_NONE;
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, event);
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, event);
> =20
> -        entry.perm =3D IOMMU_RW;
> +        event.type =3D IOMMU_NOTIFIER_MAP;
> +        event.entry.perm =3D IOMMU_RW;
>          if (block_is_ns) {
> -            entry.target_as =3D &s->blocked_io_as;
> +            event.entry.target_as =3D &s->blocked_io_as;
>          } else {
> -            entry.target_as =3D &s->downstream_as;
> +            event.entry.target_as =3D &s->downstream_as;
>          }
> -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, entry);
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_S, event);
>          if (block_is_ns) {
> -            entry.target_as =3D &s->downstream_as;
> +            event.entry.target_as =3D &s->downstream_as;
>          } else {
> -            entry.target_as =3D &s->blocked_io_as;
> +            event.entry.target_as =3D &s->blocked_io_as;
>          }
> -        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, entry);
> +        memory_region_notify_iommu(&s->upstream, IOMMU_IDX_NS, event);
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 0fecabc135..8bc3cff05d 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -445,7 +445,7 @@ static void spapr_tce_reset(DeviceState *dev)
>  static target_ulong put_tce_emu(SpaprTceTable *tcet, target_ulong ioba,
>                                  target_ulong tce)
>  {
> -    IOMMUTLBEntry entry;
> +    IOMMUTLBEvent event;
>      hwaddr page_mask =3D IOMMU_PAGE_MASK(tcet->page_shift);
>      unsigned long index =3D (ioba - tcet->bus_offset) >> tcet->page_shif=
t;
> =20
> @@ -457,12 +457,13 @@ static target_ulong put_tce_emu(SpaprTceTable *tcet=
, target_ulong ioba,
> =20
>      tcet->table[index] =3D tce;
> =20
> -    entry.target_as =3D &address_space_memory,
> -    entry.iova =3D (ioba - tcet->bus_offset) & page_mask;
> -    entry.translated_addr =3D tce & page_mask;
> -    entry.addr_mask =3D ~page_mask;
> -    entry.perm =3D spapr_tce_iommu_access_flags(tce);
> -    memory_region_notify_iommu(&tcet->iommu, 0, entry);
> +    event.entry.target_as =3D &address_space_memory,
> +    event.entry.iova =3D (ioba - tcet->bus_offset) & page_mask;
> +    event.entry.translated_addr =3D tce & page_mask;
> +    event.entry.addr_mask =3D ~page_mask;
> +    event.entry.perm =3D spapr_tce_iommu_access_flags(tce);
> +    event.type =3D entry.perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMA=
P;
> +    memory_region_notify_iommu(&tcet->iommu, 0, event);
> =20
>      return H_SUCCESS;
>  }
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index f37a4569ac..b87e9f688e 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1906,11 +1906,15 @@ void memory_region_unregister_iommu_notifier(Memo=
ryRegion *mr,
>  }
> =20
>  void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
> -                                    IOMMUTLBEntry *entry)
> +                                    IOMMUTLBEvent *event)
>  {
> -    IOMMUNotifierFlag request_flags;
> +    IOMMUTLBEntry *entry =3D &event->entry;
>      hwaddr entry_end =3D entry->iova + entry->addr_mask;
> =20
> +    if (event->type =3D=3D IOMMU_NOTIFIER_UNMAP) {
> +        assert(entry->perm =3D=3D IOMMU_NONE);
> +    }
> +
>      /*
>       * Skip the notification if the notification does not overlap
>       * with registered range.
> @@ -1921,20 +1925,14 @@ void memory_region_notify_iommu_one(IOMMUNotifier=
 *notifier,
> =20
>      assert(entry->iova >=3D notifier->start && entry_end <=3D notifier->=
end);
> =20
> -    if (entry->perm & IOMMU_RW) {
> -        request_flags =3D IOMMU_NOTIFIER_MAP;
> -    } else {
> -        request_flags =3D IOMMU_NOTIFIER_UNMAP;
> -    }
> -
> -    if (notifier->notifier_flags & request_flags) {
> +    if (event->type & notifier->notifier_flags) {
>          notifier->notify(notifier, entry);
>      }
>  }
> =20
>  void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
>                                  int iommu_idx,
> -                                IOMMUTLBEntry entry)
> +                                IOMMUTLBEvent event)
>  {
>      IOMMUNotifier *iommu_notifier;
> =20
> @@ -1942,7 +1940,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *=
iommu_mr,
> =20
>      IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
>          if (iommu_notifier->iommu_idx =3D=3D iommu_idx) {
> -            memory_region_notify_iommu_one(iommu_notifier, &entry);
> +            memory_region_notify_iommu_one(iommu_notifier, &event);
>          }
>      }
>  }
> --=20
> 2.18.1


