Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA635C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 06:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4B721775
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 06:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgjBKDyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4B721775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUldH-0003F4-Hy
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 02:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUlcd-0001KV-0N
 for qemu-devel@nongnu.org; Sat, 02 May 2020 02:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jUlbq-00063m-47
 for qemu-devel@nongnu.org; Sat, 02 May 2020 02:27:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jUlbp-0005zk-Kg
 for qemu-devel@nongnu.org; Sat, 02 May 2020 02:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588400804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icbzzeJgFpzjqBnzqfwNArE0/TauMADlli3cEM92VVY=;
 b=VgjBKDylNGwI7XKYAw4y2/m0J4W2g3wOxTxHGlpLyHZMIrhBd8F17cKyDQG9XHZ5mGB+9F
 sj9dggAWTosvyAC/PIBmH3BB2zUq3Hy0E90GtFlNK46R233k5m5EAhSKDeettrvv7wf2RK
 qVSFytkn9rZo+e1DPth6abSG0gtV/q8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-AII0NWlUMtaB6vLnmtvnMg-1; Sat, 02 May 2020 02:26:40 -0400
X-MC-Unique: AII0NWlUMtaB6vLnmtvnMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B970C80572D;
 Sat,  2 May 2020 06:26:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E33865C1BE;
 Sat,  2 May 2020 06:26:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74CEF11358BC; Sat,  2 May 2020 08:26:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/17] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes, eaes}-256
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-9-armbru@redhat.com>
 <7ed42e2f-e437-3d06-e46b-5416e4d2a6d3@redhat.com>
 <874kt0bzq8.fsf@dusky.pond.sub.org>
 <83638290-f00e-7d50-225b-efee0179ff9c@redhat.com>
Date: Sat, 02 May 2020 08:26:34 +0200
In-Reply-To: <83638290-f00e-7d50-225b-efee0179ff9c@redhat.com> (David
 Hildenbrand's message of "Fri, 1 May 2020 11:06:14 +0200")
Message-ID: <87368i6eed.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 30.04.20 20:22, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>=20
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
>>=20
>> :)
>>=20
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
>>=20
>> Would you like to propose an commit message improvements?
>
> Maybe something like
>
> "Both affected features are part of the feature group msa4. In current
> setups, we will always see the msa4 feature instead of the separate
> contained sub-features (because all sub-features are around). Therefore,
> both features are currently never passed from/to the user explicitly
> (e.g., via cpu model expansion, comparison, baseline and '-cpu' setup)."
>
> Thanks!

I think I can guess how this could work for reporting features (I
haven't checked my guess against the code), which is what the
query-cpu-model-* do: suppress individual features when their group is
complete.

But "'-cpu' setup" doesn't seem to be about reporting features.  Am I
confused?

While testing, I noticed that

    $ s390x-softmmu/qemu-system-s390x

flashes a window at me, then terminates successfully, without printing
anything.  With -S, it behaves like other targets.  Bug?


