Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57658C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231EF206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2FKNt4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231EF206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isS5l-0001Cm-Rn
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isS3F-0006I1-WB
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isS3E-0007go-Oc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isS3E-0007gA-L6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=xJ5Xjt5bIsbULo90MZvNBTLFFxonKOydO1ZV0fR72tk=;
 b=X2FKNt4eO6GR/K32c9AOaQKGPHRVtE0v9WmUWYFE9BoyRmZsAKGAiwW0utYBYqbq4dMTL2
 bQkkWfv2YT4BDHDvRttTILyKOIV3CROti/kZr7OYrGRaYdyyEGX1nsMBsocGPpBlRimEH+
 Qom5Yu64VFOkReguDYI1AEhbF/maGBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-bPHxyyZePh-KzRRrkla6hw-1; Fri, 17 Jan 2020 08:52:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 397E51800D48
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 13:52:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EBB45D9CD;
 Fri, 17 Jan 2020 13:52:36 +0000 (UTC)
Subject: Re: [PATCH v2 83/86] tests:numa-test: make top level args dynamic and
 g_autofree(cli) cleanups
To: Igor Mammedov <imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-84-git-send-email-imammedo@redhat.com>
 <20e88588-13b4-8c7d-3f97-cb2d50b85edd@redhat.com>
 <20200116180606.134cb1a6@redhat.com>
 <a0b60484-d5fb-7409-b13e-4e70d1177138@redhat.com>
 <20200117143305.7eb9571e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a1a1720a-899e-8e30-662f-757ace5a0d05@redhat.com>
Date: Fri, 17 Jan 2020 14:52:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200117143305.7eb9571e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bPHxyyZePh-KzRRrkla6hw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/01/2020 14.33, Igor Mammedov wrote:
> On Fri, 17 Jan 2020 12:14:11 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 16/01/2020 18.06, Igor Mammedov wrote:
>>> On Thu, 16 Jan 2020 17:35:32 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>  =20
>>>> On 15/01/2020 16.07, Igor Mammedov wrote: =20
>>>>> Use GString to pass argument to make_cli() so that it would be easy
>>>>> to dynamically change test case arguments from main(). The follow up
>>>>> patch will use it to change RAM size options depending on target.
>>>>>
>>>>> While at it cleanup 'cli' freeing, using g_autofree annotation.   =20
>>>>
>>>> Hmm, I'd use g_autofree for new code or do it in a separate cleanup
>>>> patch, but doing this here distracts quite a bit from the real changes
>>>> that you are doing... =20
>>> I'll split it into separate patch
>>>  =20
>>>> =20
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> ---
>>>>> PS:
>>>>>   made as a separate patch so it won't clutter followup testcase chan=
ges.
>>>>>
>>>>> CC: thuth@redhat.com
>>>>> CC: lvivier@redhat.com
>>>>> ---
>>>>>  tests/qtest/numa-test.c | 38 ++++++++++++++------------------------
>>>>>  1 file changed, 14 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
>>>>> index 17dd807..a696dfd 100644
>>>>> --- a/tests/qtest/numa-test.c
>>>>> +++ b/tests/qtest/numa-test.c
>>>>> @@ -14,16 +14,16 @@
>>>>>  #include "qapi/qmp/qdict.h"
>>>>>  #include "qapi/qmp/qlist.h"
>>>>> =20
>>>>> -static char *make_cli(const char *generic_cli, const char *test_cli)
>>>>> +static char *make_cli(const GString *generic_cli, const char *test_c=
li)
>>>>>  {
>>>>> -    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", =
test_cli);
>>>>> +    return g_strdup_printf("%s %s", generic_cli->str, test_cli);
>>>>>  }   =20
>>>> [...] =20
>>>>> @@ -539,11 +529,11 @@ static void pc_hmat_erange_cfg(const void *data=
)
>>>>> =20
>>>>>  int main(int argc, char **argv)
>>>>>  {
>>>>> -    const char *args =3D NULL;
>>>>> +    g_autoptr(GString) args =3D g_string_new("");   =20
>>>>
>>>> I think g_string_new(NULL) would be better?
>>>> =20
>>>>>      const char *arch =3D qtest_get_arch();
>>>>> =20
>>>>>      if (strcmp(arch, "aarch64") =3D=3D 0) {
>>>>> -        args =3D "-machine virt";
>>>>> +        g_string_append(args, " -machine virt")>      }   =20
>>>>
>>>> Is this really required? Looking at your next patch, you could also
>>>> simply do
>>>>
>>>>           args =3D " -object memory-backend-ram,id=3Dram,size=3DxxxM" =
=20
>>> xxx is variable so options are
>>>  1 build this part of CLI dynamically
>>>  2 mostly duplicate testcase function and include per target size there
>>>  3 make up a test data structure and pass that to test cases
>>>
>>> Given simplicity of current testcases, I'd prefer continue with
>>> passing CLI as testcase data (option #1). =20
>>
>> Sorry, I think I missed something here... currently I see in the next pa=
tch:
>>
>> +    if (!strcmp(arch, "ppc64")) {
>> +        g_string_append(args, " -object
>> memory-backend-ram,id=3Dram,size=3D512M");
>> +    } else {
>> +        g_string_append(args, " -object
>> memory-backend-ram,id=3Dram,size=3D128M");
>> +    }
>>
>> ... so these are static strings which could also be handled fine without
>> GString? Or do you plan to update this in later patches?
> it's 1 or concatenation of 2 strings
>   " -object memory-backend-ram,id=3Dram,size=3D128M"
>   " -object memory-backend-ram,id=3Dram,size=3D512M"
>   " -machine virt" + " -object memory-backend-ram,id=3Dram,size=3D128M"

Ah, well, that's what I was missing. Since the if-arch-statements follow
close to each other, I somehow read 'else if (!strcmp(arch, "ppc64"))'
... sorry for that.
Maybe it's more obvious if you'd do it the other way round, first the
"-object" lines, then the "-machine virt" stuff?

Anyway, another note: It's a little bit ugly that one if-statment uses
strcmp() !=3D 0 while the other one uses !strcmp() ... since you're using
GLIB code here anyway, what do you think about converting them to
g_str_equal() instead?

 Thomas


