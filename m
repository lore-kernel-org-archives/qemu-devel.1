Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016D12088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmN1pd7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016D12088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKiJ-0002Sw-B7
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrKgw-0001bG-4G
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:21:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60759
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrKgt-0004Zu-Am
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593778874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFZaiDUGq9XKA6+Nv/EAsHQzDgTIil5M4zIbcIwkIqc=;
 b=gmN1pd7vWW6GzT7vRxV26a7Bikolv477Xz/Kwg/GI8KBWn0oT+qbd/vazVnQlugXwkkGxI
 SbOWhFpcL2c/Q9wGv4Rg2D3N/3btQO/yBS2/jUEUW1F+tUIuH3ucKjqmPg2iQiF/LCS+85
 puCEQ0ZKaz72A5sTwtp+XSb+Iasnqjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-qFUObpYdN-iJbTl3QoP64A-1; Fri, 03 Jul 2020 08:21:10 -0400
X-MC-Unique: qFUObpYdN-iJbTl3QoP64A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6447818FE861;
 Fri,  3 Jul 2020 12:21:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 367C9B3A79;
 Fri,  3 Jul 2020 12:21:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7B1D1138648; Fri,  3 Jul 2020 14:21:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org>
Date: Fri, 03 Jul 2020 14:21:07 +0200
In-Reply-To: <87blo7heag.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Sat, 04 Apr 2020 09:59:35 +0200")
Message-ID: <874kqooklo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> QEMU's Error was patterned after GLib's GError.  Differences include:
> [...]
>> * Return value conventions
>>
>>   Common: non-void functions return a distinct error value on failure
>>   when such a value can be defined.  Patterns:
>>
>>   - Functions returning non-null pointers on success return null pointer
>>     on failure.
>>
>>   - Functions returning non-negative integers on success return a
>>     negative error code on failure.
>>
>>   Different: GLib discourages void functions, because these lead to
>>   awkward error checking code.  We have tons of them, and tons of
>>   awkward error checking code:
>>
>>     Error *err = NULL;
>>     frobnicate(arg, &err);
>>     if (err) {
>>         ... recover ...
>>         error_propagate(errp, err);
>>     }
>>
>>   instead of
>>
>>     if (!frobnicate(arg, errp))
>>         ... recover ...
>>     }
>>
>>   Can also lead to pointless creation of Error objects.
>>
>>   I consider this a design mistake.  Can we still fix it?  We have more
>>   than 2000 void functions taking an Error ** parameter...
>>
>>   Transforming code that receives and checks for errors with Coccinelle
>>   shouldn't be hard.  Transforming code that returns errors seems more
>>   difficult.  We need to transform explicit and implicit return to
>>   either return true or return false, depending on what we did to the
>>   @errp parameter on the way to the return.  Hmm.
> [...]
>
> To figure out what functions with an Error ** parameter return, I used
> Coccinelle to find such function definitions and print the return types.
> Summary of results:
>
>    2155 void
>     873 signed integer
>     494 pointer
>     153 bool
>      33 unsigned integer
>       6 enum
>    ---------------------
>    3714 total

With my "[PATCH v2 00/44] Less clumsy error checking" applied, I now count

     1946 void
      879 signed integer
      484 pointer
      301 bool
       33 unsigned integer
        3 GuestFsfreezeStatus
        1 gnutls_x509_crt_t
        1 QCryptoCipherAlgorithm
        1 COLOMessage
        1 BlockdevDetectZeroesOptions
     ---------------------
     3650 total

About 7% complete for function definitions.

> I then used Coccinelle to find checked calls of void functions (passing
> &error_fatal or &error_abort is not considered "checking" here).  These
> calls become simpler if we make the functions return a useful value.  I
> found a bit under 600 direct calls, and some 50 indirect calls.

Different method this time: I count any direct function call that takes
&err other than &error_abort, &error_fatal, and whose value, if any, is
not used.

Current master: 1050

With my "[PATCH v2 00/44] Less clumsy error checking" applied: 649

About 38% complete for function calls.

> Most frequent direct calls:
>
>     127 object_property_set_bool
>      27 qemu_opts_absorb_qdict
>      16 visit_type_str
>      14 visit_type_int
>      10 visit_type_uint32

Top scorers master:

    151 sysbus_realize()
     34 qemu_opts_absorb_qdict()
     29 visit_type_int()
     24 visit_type_str()
     23 cpu_exec_realizefn()
     19 visit_type_size()
     16 qdev_realize()
     14 visit_type_bool()
     12 visit_type_uint32()
     11 visit_type_int32()
     11 object_property_set_bool()
     10 object_property_set_uint()
     10 object_property_set_int()
    +420 functions with fewer than 10 calls

Top scorers with my patches applied:

     23 cpu_exec_realizefn()
     15 visit_type_int()
     10 visit_type_size()
    +387 functions with fewer than 10 calls

Looks like this is going to be a long slog.

With functions into buckets by same name prefix up to the first '_':

     63 visit
     57 qmp
     33 bdrv
     29 cpu
     26 xen
     25 memory
   +113 buckets with fewer than 25 calls

[...]
>
> Please understand these are rough numbers from quick & dirty scripts.

Still are.


