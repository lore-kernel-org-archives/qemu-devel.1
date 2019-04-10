Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98734C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 06:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA1D2083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 06:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE6HR-0002wv-7H
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 02:00:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE6Gg-0002ex-A7
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE6Gf-00046L-91
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hE6Gf-00045k-2B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51667308624B;
	Wed, 10 Apr 2019 05:59:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF65861994;
	Wed, 10 Apr 2019 05:59:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 974401138648; Wed, 10 Apr 2019 07:59:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
	<874l764eez.fsf@dusky.pond.sub.org>
	<38442eb0-501e-dbf8-60e0-74675a999dba@redhat.com>
Date: Wed, 10 Apr 2019 07:59:21 +0200
In-Reply-To: <38442eb0-501e-dbf8-60e0-74675a999dba@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	10 Apr 2019 07:44:10 +0200")
Message-ID: <87bm1e2yfa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 10 Apr 2019 05:59:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, qemu-devel@nongnu.org,
	slp@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410055921.DIFAwkq3kEX0oRGSE_0pCUeG-iUhXAOs-t9yBJ8nX8A@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/10/19 7:28 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>> On 4/9/19 7:40 PM, Markus Armbruster wrote:
>>>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>>>> computation of @dt_size overflows to a negative number, which then
>>>> gets converted to a very large size_t for g_malloc0() and
>>>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>>>> succeeds and load_image_size() survives, we'd assign the negative
>>>> number to *sizep.  What that would do to the callers I can't say, but
>>>> it's unlikely to be good.
>>>>
>>>> Fix by rejecting images whose size would overflow.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  device_tree.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/device_tree.c b/device_tree.c
>>>> index 296278e12a..f8b46b3c73 100644
>>>> --- a/device_tree.c
>>>> +++ b/device_tree.c
>>>> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, i=
nt *sizep)
>>>>                       filename_path);
>>>>          goto fail;
>>>>      }
>>>> +    if (dt_size > INT_MAX / 2 - 10000) {
>>>
>>> We should avoid magic number duplication.
>>> That said, this patch looks safe.
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>=20
>> Thanks!
>>=20
>>> BTW how did you figure that out?
>>=20
>> Downstream handling of upstream commit da885fe1ee8 led me to the
>> function.  I spotted dt_size =3D get_image_size(filename_path).
>> Experience has taught me to check the left hand side's type.  Bad.  Then
>> I saw how dt_size gets increased.  Worse.
>
> So you genuinely neglected to mention Kurtis Miller then :)

Explanation, not excuse: the only occurence of the name in my downstream
reading was a two-liner BZ comment, which I totally missed in my haste
to give the fix a chance to make 4.0.  I certainly didn't mean to
deprive him of credit!

[...]

