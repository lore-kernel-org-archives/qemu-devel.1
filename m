Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA9CC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780C5206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 20:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIcFhN/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780C5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if8DW-0003FR-JN
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 15:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1if8Cm-0002oQ-OV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1if8Ci-0003DW-W6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:03:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22908
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1if8Ci-0003Al-QM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 15:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576094603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+eu7sW2aUtOwHw+MDF9g8/9MW/S1EqzquuxhC9F444=;
 b=AIcFhN/43a5za0Jx/QtoI8e67c04GumgI86mTphkBxauFRa3LezCTvp7NGMS5LoE9CsN30
 8DVxdWnwCjoZpSyyMVgsqh6jox6Dm0rlLFoBMkHa7FnnKDn/X+K+mG7DKSWDZmiC/3s6Qj
 8PP0KwefHv1Fby4cOdevJ47aZehPaPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-O84qUDIUPQ-N29hcQ2ux0w-1; Wed, 11 Dec 2019 15:03:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3373107ACC5;
 Wed, 11 Dec 2019 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-129.rdu2.redhat.com
 [10.10.122.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE74410013A1;
 Wed, 11 Dec 2019 20:03:13 +0000 (UTC)
Subject: Re: [RFC PATCH] scripts/tap-driver: report "slow" tests (HACK)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com
References: <20191113142101.30280-1-alex.bennee@linaro.org>
 <871ru4gv1p.fsf@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <04d659dd-dde0-4139-bfec-9f12e07fee44@redhat.com>
Date: Wed, 11 Dec 2019 18:03:12 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <871ru4gv1p.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: O84qUDIUPQ-N29hcQ2ux0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/19/19 5:54 AM, Alex Benn=C3=A9e wrote:
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Some tests seem to run slower on CI systems but we don't really get
>> visibility of which it is unless we happen to hang the test at the end
>> of a run. This hacky change exposes "slow" tests in the tap output.
>>
>> [AJB: my perl is rusty, I'm sure this could be more idiomatic]
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ping? It would be nice to get this or something similar in 4.2

I tested `make check` with this patch but I could not notice any=20
different on output. Likely none of the tests ran beyond the time=20
threshold. At least make check did not crash miserably, so:

Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
>> ---
>>   scripts/tap-driver.pl | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/tap-driver.pl b/scripts/tap-driver.pl
>> index 6621a5cd671..0fe748d5de6 100755
>> --- a/scripts/tap-driver.pl
>> +++ b/scripts/tap-driver.pl
>> @@ -29,6 +29,7 @@ use strict;
>>   use Getopt::Long ();
>>   use TAP::Parser;
>>   use Term::ANSIColor qw(:constants);
>> +use Time::HiRes qw( time );
>>
>>   my $ME =3D "tap-driver.pl";
>>   my $VERSION =3D "2018-11-30";
>> @@ -111,7 +112,7 @@ sub decorate_result ($);
>>   sub extract_tap_comment ($);
>>   sub handle_tap_bailout ($);
>>   sub handle_tap_plan ($);
>> -sub handle_tap_result ($);
>> +sub handle_tap_result ($$);
>>   sub is_null_string ($);
>>   sub main ();
>>   sub report ($;$);
>> @@ -220,12 +221,18 @@ sub testsuite_error ($)
>>     report "ERROR", "- $_[0]";
>>   }
>>
>> -sub handle_tap_result ($)
>> +sub handle_tap_result ($$)
>>   {
>>     $testno++;
>>     my $result_obj =3D shift;
>> +  my $time =3D shift;
>>
>>     my $test_result =3D stringify_result_obj $result_obj;
>> +
>> +  if ($time > 1.0) {
>> +    $test_result =3D $test_result . sprintf(" (%0.1fs)", $time);
>> +  }
>> +
>>     my $string =3D $result_obj->number;
>>
>>     my $description =3D $result_obj->description;
>> @@ -312,6 +319,9 @@ sub main ()
>>   {
>>     my $iterator =3D TAP::Parser::Iterator::Stream->new(\*STDIN);
>>     my $parser =3D TAP::Parser->new ({iterator =3D> $iterator });
>> +  my ($start, $end);
>> +
>> +  $start =3D time();
>>
>>     STDOUT->autoflush(1);
>>     while (defined (my $cur =3D $parser->next))
>> @@ -325,7 +335,9 @@ sub main ()
>>           }
>>         elsif ($cur->is_test)
>>           {
>> -          handle_tap_result ($cur);
>> +          $end =3D time();
>> +          handle_tap_result ($cur, $end - $start);
>> +          $start =3D time();
>>           }
>>         elsif ($cur->is_bailout)
>>           {
>
> --
> Alex Benn=C3=A9e
>


