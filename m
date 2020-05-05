Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE27C47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16258206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehoFkboO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16258206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVqt5-0008AE-OX
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 02:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVqsN-0007ji-44
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:16:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53587
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVqsK-0005kc-Ga
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588659373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2RRY/gTUkUfZhC+e1uLciqWbi3swoTEZtFeuoGAhXc=;
 b=ehoFkboOg/lBDryK1x0K07sIbYGpYc0ifzLxkwJWWRuSjtIawr/2UbfgFYDGuZtKLa5YOO
 fdHD4RYcTR48jRIqYlI4H69f70pPdnnlg8hYbyGJx1tk6tO1ApamSLmkBUsdMRCNUHBWnj
 X8lOwFUdqwQVettuvkQuW3e7v/RiC+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-HPw3uSDdNYyyJMOSD3Jk2w-1; Tue, 05 May 2020 02:16:11 -0400
X-MC-Unique: HPw3uSDdNYyyJMOSD3Jk2w-1
Received: by mail-wr1-f70.google.com with SMTP id g7so687925wrw.18
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 23:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ufgd9kHyANGWBH2bCKEf4neqe7crm05VeflkDax3isA=;
 b=b/pNS5rUOIjEfzX3FValsF0qhlmbc4D2ToPv1c1QXeY1+sIfYsYr52bPDUJk8PrgHo
 54jbG8oU451+MoXWVwVGZ9wLnu7ijTtT8EyFM2TXWbjpiDr5W2DbXj22UO/3cYfZ6+pi
 qGlE1nC+/PdrySMbrwygYX+FLvbi9jNgN3Djl6kVkHvCDjw02dnrOp+55/ca67nnRCFp
 CPt/Vpll6FDgQp5h5/JylolfDhdgl5FI5ZaVJtLT0irebiYbv8or1TPnKBjc6G2AJOYb
 We5SSZcTqCJrqq5oqwBhJtACeNWH0hvEC9c3s+mOyySH8UHU10q4Y6y0AHQdYiDeu61x
 uwDQ==
X-Gm-Message-State: AGi0PuYo24KjfdwjdZjV42iquUtzcuGV8AlPT8CZ883+v8Qp9G941ypF
 2nX3BbeK/0o9w/T8zGyW6VsTnHRBUE2IK4n4BI2SILgMmmHyL7kOvShkJ7cMydQGm6e6eQnHvZf
 8YyuDiu6fpG/xZNk=
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr1681397wrv.75.1588659370793; 
 Mon, 04 May 2020 23:16:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypLFsZxxovi5/zMS+htSr4tgB46kx+IeKcwCewctTRJ2xzA16RI+h5svnx1QpGzmfxyA6FMcMw==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr1681350wrv.75.1588659370509; 
 Mon, 04 May 2020 23:16:10 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id k14sm1377529wrp.53.2020.05.04.23.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 23:16:09 -0700 (PDT)
Subject: Re: [PATCH v18 QEMU 02/18] vfio: Add function to unmap VFIO region
To: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com,
 cjia@nvidia.com
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
 <1588632293-18932-3-git-send-email-kwankhede@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9747d731-4547-5689-8f40-61d3a2945078@redhat.com>
Date: Tue, 5 May 2020 08:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588632293-18932-3-git-send-email-kwankhede@nvidia.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 quintela@redhat.com, zhi.a.wang@intel.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kirti,

On 5/5/20 12:44 AM, Kirti Wankhede wrote:
> This function will be used for migration region.
> Migration region is mmaped when migration starts and will be unmapped whe=
n
> migration is complete.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/vfio/common.c              | 20 ++++++++++++++++++++
>   hw/vfio/trace-events          |  1 +
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 22 insertions(+)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3593b3c0c4..4a2f0d6a2233 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -983,6 +983,26 @@ int vfio_region_mmap(VFIORegion *region)
>       return 0;
>   }
>  =20
> +void vfio_region_unmap(VFIORegion *region)
> +{
> +    int i;
> +
> +    if (!region->mem) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < region->nr_mmaps; i++) {

I'd refactor this  block <...
> +        trace_vfio_region_unmap(memory_region_name(&region->mmaps[i].mem=
),
> +                                region->mmaps[i].offset,
> +                                region->mmaps[i].offset +
> +                                region->mmaps[i].size - 1);
> +        memory_region_del_subregion(region->mem, &region->mmaps[i].mem);
> +        munmap(region->mmaps[i].mmap, region->mmaps[i].size);
> +        object_unparent(OBJECT(&region->mmaps[i].mem));
> +        region->mmaps[i].mmap =3D NULL;

...> into a helper and reuse it in vfio_region_mmap(). Well, actually=20
I'd factor it out from vfio_region_mmap() then reuse it here. Anyway=20
this is v18 so can be done later on top.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +    }
> +}
> +
>   void vfio_region_exit(VFIORegion *region)
>   {
>       int i;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index b1ef55a33ffd..8cdc27946cb8 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -111,6 +111,7 @@ vfio_region_mmap(const char *name, unsigned long offs=
et, unsigned long end) "Reg
>   vfio_region_exit(const char *name, int index) "Device %s, region %d"
>   vfio_region_finalize(const char *name, int index) "Device %s, region %d=
"
>   vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %=
s mmaps enabled: %d"
> +vfio_region_unmap(const char *name, unsigned long offset, unsigned long =
end) "Region %s unmap [0x%lx - 0x%lx]"
>   vfio_region_sparse_mmap_header(const char *name, int index, int nr_area=
s) "Device %s region %d: %d sparse mmap entries"
>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long=
 end) "sparse entry %d [0x%lx - 0x%lx]"
>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_=
t subtype) "%s index %d, %08x/%0x8"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index fd564209ac71..8d7a0fbb1046 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -171,6 +171,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbased=
ev, VFIORegion *region,
>                         int index, const char *name);
>   int vfio_region_mmap(VFIORegion *region);
>   void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
> +void vfio_region_unmap(VFIORegion *region);
>   void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   void vfio_reset_handler(void *opaque);
>=20


