Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95924C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6595D24958
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 19:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Wap6xo7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6595D24958
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWPeL-0001Bv-K7
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 15:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jWPdc-0000lT-Kb
 for qemu-devel@nongnu.org; Wed, 06 May 2020 15:23:24 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jWPdb-0002BR-8j
 for qemu-devel@nongnu.org; Wed, 06 May 2020 15:23:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb30e990001>; Wed, 06 May 2020 12:23:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 06 May 2020 12:23:17 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 06 May 2020 12:23:17 -0700
Received: from [10.40.101.152] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 May
 2020 19:23:08 +0000
Subject: Re: [PATCH v18 QEMU 02/18] vfio: Add function to unmap VFIO region
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <alex.williamson@redhat.com>, <cjia@nvidia.com>
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
 <1588632293-18932-3-git-send-email-kwankhede@nvidia.com>
 <9747d731-4547-5689-8f40-61d3a2945078@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <ba999ab9-27eb-ebc5-14e7-84ddd6ab4f2d@nvidia.com>
Date: Thu, 7 May 2020 00:53:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9747d731-4547-5689-8f40-61d3a2945078@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588792985; bh=724FqxVf63Y+LUizwiFaeKmscdUQ123rnDqMYzzwy2w=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Wap6xo7V/paJCxGYRml55M7LicoopuBG/YHKFoakrJHduziL+8Qbuaa+2rHwOiVc+
 mbpq3aKlkcziYOdF4Wsfa4DikNNlDNvAiSQKQkj831UA6hzIe56Va1Gv3m25sj384a
 gL2L7TeJuhsF6sDpgCKwPG+47AnWUZAE1i878sMoNLDzgZVaKuEBSrd3ndzVzbMEto
 jAT7L5/7BkYnOkaS/m2741JyrR5VU301HKHLnmLgwPw64MMGjOi9S4w5fah9rP3V29
 3xnPiKAe7aMDFytL8JUi80I6JiS3/A95AYAXPUKxtH5qQfKmLWD99JPVozPKT1miEs
 aKivUFYJ8ODTA==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 15:23:18
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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



On 5/5/2020 11:46 AM, Philippe Mathieu-Daud=E9 wrote:
> Hi Kirti,
>=20
> On 5/5/20 12:44 AM, Kirti Wankhede wrote:
>> This function will be used for migration region.
>> Migration region is mmaped when migration starts and will be unmapped=20
>> when
>> migration is complete.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>> =A0 hw/vfio/common.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 20 +++++++=
+++++++++++++
>> =A0 hw/vfio/trace-events=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
>> =A0 include/hw/vfio/vfio-common.h |=A0 1 +
>> =A0 3 files changed, 22 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 0b3593b3c0c4..4a2f0d6a2233 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -983,6 +983,26 @@ int vfio_region_mmap(VFIORegion *region)
>> =A0=A0=A0=A0=A0 return 0;
>> =A0 }
>> +void vfio_region_unmap(VFIORegion *region)
>> +{
>> +=A0=A0=A0 int i;
>> +
>> +=A0=A0=A0 if (!region->mem) {
>> +=A0=A0=A0=A0=A0=A0=A0 return;
>> +=A0=A0=A0 }
>> +
>> +=A0=A0=A0 for (i =3D 0; i < region->nr_mmaps; i++) {
>=20
> I'd refactor this=A0 block <...
>> +       =20
>> trace_vfio_region_unmap(memory_region_name(&region->mmaps[i].mem),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 region->mmaps[i].offset,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 region->mmaps[i].offset +
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 region->mmaps[i].size - 1);
>> +=A0=A0=A0=A0=A0=A0=A0 memory_region_del_subregion(region->mem, &region-=
>mmaps[i].mem);
>> +=A0=A0=A0=A0=A0=A0=A0 munmap(region->mmaps[i].mmap, region->mmaps[i].si=
ze);
>> +=A0=A0=A0=A0=A0=A0=A0 object_unparent(OBJECT(&region->mmaps[i].mem));
>> +=A0=A0=A0=A0=A0=A0=A0 region->mmaps[i].mmap =3D NULL;
>=20
> ...> into a helper and reuse it in vfio_region_mmap(). Well, actually=20
> I'd factor it out from vfio_region_mmap() then reuse it here. Anyway=20
> this is v18 so can be done later on top.
>=20

Nevermind, this is not the last version, I'll do suggested change.

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20

Thanks,
Kirti

>> +=A0=A0=A0 }
>> +}
>> +
>> =A0 void vfio_region_exit(VFIORegion *region)
>> =A0 {
>> =A0=A0=A0=A0=A0 int i;
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index b1ef55a33ffd..8cdc27946cb8 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -111,6 +111,7 @@ vfio_region_mmap(const char *name, unsigned long=20
>> offset, unsigned long end) "Reg
>> =A0 vfio_region_exit(const char *name, int index) "Device %s, region %d"
>> =A0 vfio_region_finalize(const char *name, int index) "Device %s, region=
=20
>> %d"
>> =A0 vfio_region_mmaps_set_enabled(const char *name, bool enabled)=20
>> "Region %s mmaps enabled: %d"
>> +vfio_region_unmap(const char *name, unsigned long offset, unsigned=20
>> long end) "Region %s unmap [0x%lx - 0x%lx]"
>> =A0 vfio_region_sparse_mmap_header(const char *name, int index, int=20
>> nr_areas) "Device %s region %d: %d sparse mmap entries"
>> =A0 vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned=20
>> long end) "sparse entry %d [0x%lx - 0x%lx]"
>> =A0 vfio_get_dev_region(const char *name, int index, uint32_t type,=20
>> uint32_t subtype) "%s index %d, %08x/%0x8"
>> diff --git a/include/hw/vfio/vfio-common.h=20
>> b/include/hw/vfio/vfio-common.h
>> index fd564209ac71..8d7a0fbb1046 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -171,6 +171,7 @@ int vfio_region_setup(Object *obj, VFIODevice=20
>> *vbasedev, VFIORegion *region,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 in=
t index, const char *name);
>> =A0 int vfio_region_mmap(VFIORegion *region);
>> =A0 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)=
;
>> +void vfio_region_unmap(VFIORegion *region);
>> =A0 void vfio_region_exit(VFIORegion *region);
>> =A0 void vfio_region_finalize(VFIORegion *region);
>> =A0 void vfio_reset_handler(void *opaque);
>>
>=20

