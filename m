Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D806C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9375206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 08:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfmgrEhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9375206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jia6J-0002T2-3L
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 04:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jia5W-0001zF-Vn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:58:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jia5V-00051k-FQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 04:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591693107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QGFgn4FE8bdyjLtAPqvgcsMglxF0FWvmaa3W253cpM=;
 b=bfmgrEhTBSATo7w4AFETmgLH5XxoWf/AX4f5GHZHTxmW+v2XCymDflYLYlTA4banqO4Sg7
 ubb+J+GAk/aWQjYxy3vYeiAS2OV0GT6Iamj+47zL9a14QsGyKF1TBA36ILx6efYGrO5i0i
 qfEu0B8zVJGjjOm4+wtpSdUB4EXQxrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-rJRk4Ii-PQ-d0JNuHVhW9A-1; Tue, 09 Jun 2020 04:58:23 -0400
X-MC-Unique: rJRk4Ii-PQ-d0JNuHVhW9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02012BFC0;
 Tue,  9 Jun 2020 08:58:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C16748203F;
 Tue,  9 Jun 2020 08:58:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D5FB11386A6; Tue,  9 Jun 2020 10:58:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 00/16] python: add mypy support to python/qemu
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200605092630.GE5869@linux.fritz.box>
 <502e4f4d-6770-61a7-1496-9cb244f9ddd3@redhat.com>
 <20200608153327.GD6419@linux.fritz.box>
 <130e4383-8c33-c3f2-55b2-1ec45a5214cc@redhat.com>
Date: Tue, 09 Jun 2020 10:58:20 +0200
In-Reply-To: <130e4383-8c33-c3f2-55b2-1ec45a5214cc@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 8 Jun 2020 19:41:09
 +0200")
Message-ID: <87wo4gr4yb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/8/20 5:33 PM, Kevin Wolf wrote:
>> Am 08.06.2020 um 17:19 hat John Snow geschrieben:
>>>
>>>
>>> On 6/5/20 5:26 AM, Kevin Wolf wrote:
>>>> Am 04.06.2020 um 22:22 hat John Snow geschrieben:
>>>>> Based-on: 20200604195252.20739-1-jsnow@redhat.com
>>>>>
>>>>> This series is extracted from my larger series that attempted to bund=
le
>>>>> our python module as an installable module. These fixes don't require=
 that,
>>>>> so they are being sent first as I think there's less up for debate in=
 here.
>>>>>
>>>>> This requires my "refactor shutdown" patch as a pre-requisite.
>>>>
>>>> You didn't like my previous R-b? Here's a new one. :-)
>>>>
>>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>>>
>>>
>>> I felt like I should address the feedback, and though I could have
>>> applied the R-B to patches I didn't change, it was ... faster to just
>>> re-send it.
>>>
>>> Serious question: How do you apply people's R-Bs to your patches? At th=
e
>>> moment, it's pretty manually intensive for me. I use stgit and I pop al=
l
>>> of the patches off (stg pop -n 100), and then one-at-a-time I `stg push=
;
>>> stg edit` and copy-paste the R-B into it.
>
> wget https://patchew.org/QEMU/${MSG_ID}/mbox
> git am mbox
>
> Where ${MSG_ID} is the Message-Id of the series cover letter.

Patchew's awesomeness is still under-appreciated.


