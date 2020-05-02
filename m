Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6B5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CECA20787
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 05:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F61lgG5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CECA20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUkZ9-0000vV-5X
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 01:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkYW-00088x-M3
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUkVJ-00080B-9L
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25140
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUkVI-0007zW-My
 for qemu-devel@nongnu.org; Sat, 02 May 2020 01:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588396554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGsy1sMgRtjbWdFSz4jj96jZ5CccIUHPBlycQV5XQHs=;
 b=F61lgG5K37Hu7HGcUi5U5B0pIW2+F+y3itoEdDH6uxj2l91avDQ/fBdaqjLI8YZCXU7uYH
 m3c5PKVPplKy0KJzGDzleyyMvgb8pntThuQXPcNgy8PZCk58/kk8wCX4Ywr5jNsLxMBg+y
 0gzshWZhVZ4FoMYyoQhFqLZx76jXH5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-PilJGHq7Oae5SA4km8J4oA-1; Sat, 02 May 2020 01:15:52 -0400
X-MC-Unique: PilJGHq7Oae5SA4km8J4oA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDF56800685;
 Sat,  2 May 2020 05:15:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E86550F6D;
 Sat,  2 May 2020 05:15:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1075D11358BC; Sat,  2 May 2020 07:15:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 08/17] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes, eaes}-256
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-9-armbru@redhat.com>
 <7ed42e2f-e437-3d06-e46b-5416e4d2a6d3@redhat.com>
 <29392c1a-ec17-b846-b842-5bc2f07382e6@de.ibm.com>
 <ac471bdd-675a-e620-d34a-56eabaa8c9af@de.ibm.com>
Date: Sat, 02 May 2020 07:15:46 +0200
In-Reply-To: <ac471bdd-675a-e620-d34a-56eabaa8c9af@de.ibm.com> (Christian
 Borntraeger's message of "Thu, 30 Apr 2020 20:47:08 +0200")
Message-ID: <87sggi6hod.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 01:06:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christian Borntraeger <borntraeger@de.ibm.com> writes:

> On 29.04.20 10:54, Christian Borntraeger wrote:
>>=20
>>=20
>> On 28.04.20 19:13, David Hildenbrand wrote:
>>> On 28.04.20 18:34, Markus Armbruster wrote:
>>>> Both s390_features[S390_FEAT_PCC_CMAC_AES_256].name and
>>>> s390_features[S390_FEAT_PCC_CMAC_EAES_256].name is
>>>> "pcc-cmac-eaes-256".  The former is obviously a pasto.
>>>>
>>>> Impact:
>>>>
>>>> * s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_256
>>>>   as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definitions,
>>>>   query-cpu-model-expansion, query-cpu-model-baseline,
>>>>   query-cpu-model-comparison, and the error message when
>>>>   s390_realize_cpu_model() fails in check_compatibility().
>>>>
>>>> * s390_realize_cpu_model() misidentifies it in check_consistency()
>>>>   warnings.
>>>>
>>>> * s390_cpu_list() likewise.  Affects -cpu help.
>>>>
>>>> * s390_cpu_model_register_props() creates CPU property
>>>>   "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
>>>>   ignored (a later commit will change that).  Results in a single
>>>>   property "pcc-cmac-eaes-256" with the description for
>>>>   S390_FEAT_PCC_CMAC_AES_256, and no property for
>>>>   S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -cpu
>>>>   and -device, QMP & HMP device_add, QMP device-list-properties, and
>>>>   QOM introspection.
>>>>
>>>> Fix by deleting the wayward 'e'.
>>>
>>> Very nice catch - thanks!
>>>
>>> While this sounds very bad, it's luckily not that bad in practice
>>> (currently).
>>>
>>> The feature (or rather, both features) is part of the feature group
>>> "msa4". As long as we have all sub-features part of that group (which i=
s
>>> usually the case), we will always indicate "msa4" to the user, instead
>>> of all the separate sub-features. So, expansion, baseline, comparison
>>> will usually only work with "msa4".
>>>
>>> (in addition, current KVM is not capable of actually masking off these
>>> sub-features, so it will still, always see the feature, even if not
>>> explicitly specified via "-cpu X,pcc-cmac-aes-256=3Don)
>>>
>>> I think we should do stable backports.
>>=20
>> makes sense, but I would like to do some testing upfront (old QEMU <-> n=
ew QEMU
>
> So migration does work between a qemu with and without the patch for host=
-model and
> custom model=3Dz14.=20

Is this a Tested-by?


