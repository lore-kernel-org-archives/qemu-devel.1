Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74352C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BA5208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHqQ6+2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BA5208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1hC-00061P-BS
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX1gS-00056N-Pz
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:00:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX1gQ-0005LJ-Bk
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588939248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Is8ZbMlKtRkifS3NeHdd4Kue5Bctj87j6SyPvFK3yFI=;
 b=fHqQ6+2VOmjTjiQXwbAW8I3PQxpMnZVdWeFtKyU+ZNBYo61boamr1pZS0oVJsASAGLV71K
 mBlsmOJ1VhkCeuKtcYdjT/dai46DL0t2Vz8ncJ9luu1pipYs4FR7p5nA1eRwq4yIwYi6k+
 0iM5uJZaJGtxICN9NLqe2lC0rtfHjpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-qjK3GdbuOxasGXgi_syzcg-1; Fri, 08 May 2020 08:00:46 -0400
X-MC-Unique: qjK3GdbuOxasGXgi_syzcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6BE80058A;
 Fri,  8 May 2020 12:00:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A30C1605CE;
 Fri,  8 May 2020 12:00:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2118211358BC; Fri,  8 May 2020 14:00:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 09/18] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes, eaes}-256
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-10-armbru@redhat.com>
 <d7faaa21-8ab5-81bb-3e8e-e52e002c207a@redhat.com>
Date: Fri, 08 May 2020 14:00:43 +0200
In-Reply-To: <d7faaa21-8ab5-81bb-3e8e-e52e002c207a@redhat.com> (David
 Hildenbrand's message of "Wed, 6 May 2020 13:41:11 +0200")
Message-ID: <878si2myac.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 05.05.20 17:29, Markus Armbruster wrote:
>> Both s390_features[S390_FEAT_PCC_CMAC_AES_256].name and
>> s390_features[S390_FEAT_PCC_CMAC_EAES_256].name is
>> "pcc-cmac-eaes-256".  The former is obviously a pasto.
>>=20
>> Impact:
>>=20
>> * s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_256
>>   as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definitions,
>>   query-cpu-model-expansion, query-cpu-model-baseline,
>>   query-cpu-model-comparison, and the error message when
>>   s390_realize_cpu_model() fails in check_compatibility().
>>=20
>> * s390_cpu_list() also misidentifies it.  Affects -cpu help.
>>=20
>> * s390_cpu_model_register_props() creates CPU property
>>   "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
>>   ignored (a later commit will change that).  Results in a single
>>   property "pcc-cmac-eaes-256" with the description for
>>   S390_FEAT_PCC_CMAC_AES_256, and no property for
>>   S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -cpu
>>   and -device, QMP & HMP device_add, QMP device-list-properties, and
>>   QOM introspection.
>>=20
>> Fix by deleting the wayward 'e'.
>
> You dropped the comment regarding msa4, was that intended?

Accident, will put it back.  Glad you're paying attention!


