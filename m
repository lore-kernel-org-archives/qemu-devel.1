Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F1FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984802072C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JceV6GxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984802072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZz90-0006VR-KZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZz8J-0005fn-AB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZz8G-0003hm-IK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604420763;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+7HRr9BZ61G6W/45KK7ouTft8hIOyWgP/Mhk54efXxw=;
 b=JceV6GxR++OMACY1Yi98HRZSWEQB41vYcmBBbn/AHoWUOf6QwgAOyD0gmK3aetvxHUIgt2
 8Tyz+jMZbgx4+tvGTnUoz1xgYIKu2KMeLzSJIAp4Diih8xkKRjtr2Z5p3p0VEoxJG5AZpf
 qYrzkD6B3GSD/OGiz0d3lA7Rte6Jy+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-RF4XpudUN4utJnQQ2nW9rQ-1; Tue, 03 Nov 2020 11:25:58 -0500
X-MC-Unique: RF4XpudUN4utJnQQ2nW9rQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B22D108E1A5
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 16:25:57 +0000 (UTC)
Received: from redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F48D5C1D0;
 Tue,  3 Nov 2020 16:25:56 +0000 (UTC)
Date: Tue, 3 Nov 2020 16:25:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
Message-ID: <20201103162551.GQ205187@redhat.com>
References: <20201103161339.447118-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103161339.447118-1-pbonzini@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 11:13:39AM -0500, Paolo Bonzini wrote:
> OptsVisitor, StringInputVisitor and the keyval visitor have
> three different ideas of how a human could write the value of
> a boolean option.  Pay homage to the backwards-compatibility
> gods and make the new common helper accept all four sets (on/off,
> true/false, y/n and yes/no), and case-insensitive at that.
> 
> Since OptsVisitor is supposed to match qemu-options, adjust
> it as well.

FWIW, libvirt does not appear to use true/false or y/n, nor
ever use uppercase / mixed case.

IOW this level of back compat may well be overkill.

I'd particular suggest deprecating case-insensitivity, as
Yes, YES, yEs feel unlikely to be important or widely used.

Based on libvirt test suite QEMU CLI args, I see primarily on|off,
with a small amount of yes|no:

3dnowext=on
3dnow=on
3dnowprefetch=off
aarch64=off
acpi=on
adjust=on
adjvtime=on
aefsi=on
aen=on
apft=on
ap=on
append=on
apqci=on
apqi=on
assist=on
ats=off
ats=on
avx2=off
avx=off
bpb=on
cache=off
cache=on
clflushopt=on
clwb=on
cmmnt=on
cmm=on
cmp_legacy=on
compression=off
compression=on
core=off
core=on
cpl=on
csske=on
csum=off
cte=on
data=yes
dedicated=on
deflate=on
dfppc=on
display=on
ds_cpl=on
edat2=on
edat=on
eim=on
eoi=off
eoi=on
erms=on
esop=on
esort=on
etoken=on
event_idx=off
event_idx=on
f16c=off
failover=on
fma=off
fxsr_opt=off
fxsr_opt=on
gl=on
gs=on
gso=off
guest_csum=off
guest_ecn=off
guest_tso4=off
guest_tso6=off
guest_ufo=off
hmat=on
host_ecn=off
host_tso4=off
host_tso6=off
host_ufo=off
hotplug=off
hotplug=on
htm=on
hugetlb=yes
hv=off
hypervisor=on
iep=on
info=off
info=on
intremap=on
invtsc=on
ioeventfd=off
ioeventfd=on
iommu=on
iommu_platform=off
iommu_platform=on
iotlb=on
ipter=on
kvmclock=off
kvm=off
kvm_pv_eoi=off
kvm_pv_eoi=on
kvm_pv_unhalt=off
kvm_pv_unhalt=on
la57=on
lahf_lm=on
legacy=off
legacy=on
lm=on
lock=off
lock=on
logappend=off
logappend=on
master=off
master=on
menu=off
menu=on
mepoch=on
mepochptff=on
merge=off
migration=on
misalignsse=off
mlock=off
mlock=on
mode=on
modern=off
mouse=off
mpx=on
mq=on
mrg_rxbuf=off
msa1=on
msa2=on
msa3=on
msa4=on
msa5=on
msa6=on
msa7=on
msa8=on
msa9=on
msa9_pckmo=on
msi=on
msr=on
multifunction=off
multifunction=on
nb=on
ni=off
nodeid_msr=on
npt=on
nvdimm=on
oom=off
oom=on
opt=on
osvw=off
packed=off
packed=on
pclmuldq=on
pclmulqdq=on
pcommit=on
pconfig=off
pdpe1gb=on
peer=yes
perfctr_core=on
perfctr_nb=on
pku=on
pmem=yes
pmu=off
pmu=on
ppa15=on
prealloc=yes
ramfb=on
rdrand=off
rdseed=off
read=on
readonly=on
readonly=on'
removable=off
removable=on
reporting=on
ri=on
rw=on
save=off
scsi=off
scsi=on
sea_esop2=on
share=no
share=yes
smm=on
ssbd=on
ss=on
stckf=off
sthyi=on
strict=on
sve128=on
sve256=on
sve384=off
sve512=on
sve=on
te=on
threads=on
timestamp=on
topoext=off
tsc_adjust=on
umip=on
unarmed=on
unhalt=off
unhalt=on
usb=off
value=on
vhost=on
virgl=on
vme=off
vmport=off
vmx=on
vxeh2=on
vxeh=on
vx=on
vxpdeh=on
vxpd=on
wrap=off
wrap=on
xsavec=off
xsaves=on
zeroes=on
zpci=on



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


