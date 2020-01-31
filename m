Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC55C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A46620707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZNkC+fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A46620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixalF-00035v-7K
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 13:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixakc-0002dT-Ul
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixakb-0005w2-4A
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:10:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixaka-0005qj-Ti
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 13:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580494239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Y8gJumZJgFgwgyJBpV3z+VSGYPnvNmvrfoSosGn70U=;
 b=bZNkC+frGTw7zp94nS0AkpSuHUYHCWbMANfenDCER2/hAtV71nPW5wk/r0V01UEjNEPtZh
 dwVUm7iu4DqPOXgynTmjPjc4XrOnP1KF/HKl7fcZKYsvUvC+j/r3x8WMSXh3Gk5/GtCPvi
 OLi19EayUzPm6FKshsnAbBTGAYJAEoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-A5M4W67aOnOptUA7qpEYdQ-1; Fri, 31 Jan 2020 13:10:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B94110052E8;
 Fri, 31 Jan 2020 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 551A35D9E5;
 Fri, 31 Jan 2020 18:10:23 +0000 (UTC)
Subject: Re: [PATCH 1/6] tests/boot_linux_console: add microvm acceptance test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-2-git-send-email-liam.merwick@oracle.com>
 <a968cbba-911c-ac0b-6b7e-d50e83e877e3@redhat.com>
 <acf418d0-a002-4ae0-06cc-c26bf495f3f8@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <1559491d-d8e1-8099-64b0-ec0a33d0faf1@redhat.com>
Date: Fri, 31 Jan 2020 16:10:21 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <acf418d0-a002-4ae0-06cc-c26bf495f3f8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: A5M4W67aOnOptUA7qpEYdQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/30/20 9:51 PM, Philippe Mathieu-Daud=E9 wrote:
> On 1/30/20 6:41 PM, Wainer dos Santos Moschetta wrote:
>> On 1/27/20 2:36 PM, Liam Merwick wrote:
>>> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
>>> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:'
>>> as being either 'pc' or 'microvm' can be used to test booting a
>>> compressed kernel using either machine class.
>>>
>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>> ---
>>> =A0 tests/acceptance/boot_linux_console.py | 15 +++++++++++++--
>>> =A0 1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>> b/tests/acceptance/boot_linux_console.py
>>> index e40b84651b0b..aa5b07b1c609 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -51,10 +51,9 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 os.chdir(cwd)
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.workdir + path
>>> -=A0=A0=A0 def test_x86_64_pc(self):
>>> +=A0=A0=A0 def do_test_x86_64_machine(self):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>>> @@ -70,6 +69,18 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel command line: %=
s' %=20
>>> kernel_command_line
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_pattern(console_patte=
rn)
>>> +=A0=A0=A0 def test_x86_64_pc(self):
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>
>> The test method won't inherit the 'arch' tag from=20
>> `do_test_x86_64_machine()`, so you need to explicitly 'arch' tag each=20
>> test you created in this series. If you don't do so, Avocado won't=20
>> filter out those x86_64 tests in case QEMU is built with non-x86_64=20
>> targets.
>>
>> Follows an example, I built QEMU with '--target-list=3Darm-softmmu'. I=
=20
>> got:
>>
>> ```
>>
>> (02/18)=20
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:=
=20
>> CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
>> =A0=A0(03/18)=20
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_micr=
ovm:=20
>> CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
>> =A0=A0(04/18)=20
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt:=
=20
>> PASS (1.25 s)
>>
>> ```
>>
>> OK, avocado_qemu was smart enough to skip the tests, but ideally it=20
>> should not even consider running them in the first place.
>
> This should be solved by this patch:
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07311.html
> "tests/acceptance: Use 'machine' tag to check if available in QEMU binary=
"


That patch is useful**=A0 but does not solve the problem that I point out=
=20
here. If you have a test case which is arch-specific and the arch-QEMU=20
was not built then it should not be executed. Tagging the test with=20
'arch' ensures that.

** BTW, I'm going to review it soon

- Wainer


>>
>> Thanks!
>>
>> - Wainer
>>
>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> +
>>> +=A0=A0=A0 def test_x86_64_microvm(self):
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> +
>>> =A0=A0=A0=A0=A0 def test_mips_malta(self):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:mips
>>
>
>


