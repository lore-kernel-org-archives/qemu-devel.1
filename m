Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E1C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697E6208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/JHosrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697E6208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1w0-0003Fr-HD
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX1vE-0002OZ-GZ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:16:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34740
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jX1vB-0005ax-M1
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588940164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=613xKNQtzJPLmy8zG4Vk2x8NE5dBffLRhfiTfna0bwE=;
 b=V/JHosrmhg8MQVOYsR16BKmWgljOYz/LuVKP/FRNsBY+3PDD5RScnxtuBMa1FwQHmoxIAT
 yP/kTPAjMfxHmdeJ3pWcroJmyw0AUNVZ6dEF4YrwxlquM9K/LpSUdqKKomFtoezXJoUdZQ
 oMRfMIlKDA2mA90+YZBe2Mw5utZDFdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-vwp6GS_1OKWncyD_gwrp8w-1; Fri, 08 May 2020 08:16:00 -0400
X-MC-Unique: vwp6GS_1OKWncyD_gwrp8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 537FD80183C;
 Fri,  8 May 2020 12:15:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E2D410013BD;
 Fri,  8 May 2020 12:15:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D8D5B11358BC; Fri,  8 May 2020 14:15:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 09/18] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes, eaes}-256
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-10-armbru@redhat.com>
 <20200506133138.4443502c.cohuck@redhat.com>
Date: Fri, 08 May 2020 14:15:54 +0200
In-Reply-To: <20200506133138.4443502c.cohuck@redhat.com> (Cornelia Huck's
 message of "Wed, 6 May 2020 13:31:38 +0200")
Message-ID: <87368amxl1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cornelia Huck <cohuck@redhat.com> writes:

> On Tue,  5 May 2020 17:29:17 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
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
>>=20
>> Fixes: 782417446279717aa85320191a519b51f6d5dd31
>
> I like the more standard
>
> Fixes: 782417446279 ("s390x/cpumodel: introduce CPU features")
>
> for that.

For a value of "standard" :)

    $ git-log --since 'one year ago' master | sed -n 's/^ *Fixes: *//p' | s=
ed -E 's/^[a-f0-9]{40}/SHA/i;s/^[a-f0-9]{4,}/ABBREV-SHA/i;s/^https?:[^ ]*/U=
RL/;s/^(Coverity )?CID [^ ]*/CID/;s/^CVE-[^ ]*/CVE/;s/".*"/"MSG"/;s/\(.*\)/=
(MSG)/'| sort | uniq -c | grep -v '^ *1 ' | sort -nr=20
        204 ABBREV-SHA (MSG)
        132 ABBREV-SHA
         85 SHA
         43 URL
         23 ABBREV-SHA "MSG"
         11 CID
          5=20
          3 CVE
          2 add read-zeroes to 051.out
          2 CID (MSG)

I'll tweak it for you, of course.

>> Cc: Halil Pasic <pasic@linux.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: qemu-s390x@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu_features_def.inc.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>
> I assume you'll take this one together with the rest of the series?

Yes.

Thank you!


