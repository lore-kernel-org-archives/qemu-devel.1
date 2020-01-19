Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C663EC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898FB2064C
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSjvtdnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898FB2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it8t4-0004Yb-PD
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 06:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8sT-00048n-3I
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8sR-0002PP-TR
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:36:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8sR-0002Oo-LS
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:36:23 -0500
Received: by mail-wm1-x342.google.com with SMTP id w5so12705913wmi.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 03:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pVMLjmysx/GAxoOSlchhJrjzKdlg8+FB1XEtBsIhF8M=;
 b=DSjvtdnAJj922tNKjBC8k2VI8k6IkGC2ZlMBIw6mftskn7iODTVXbc30FOWg+Art1m
 tBpIwixo8T55awqmJSrZBctFW3HadT1xxpMvCSG532WjXYRM0KO0y/O7YcAaCUVmv4Dz
 mTA6Z2IJEw07PUBtwhhDLnEs/LR6dRdQ1NVxamqdk9CMJ5W3t8A6q7X9V1jegDWwavsJ
 50xGOE/xoA6sSP+uw+Tq3g/E7UGOQkth3oJ5OW+/IHr76zbCl3voc+rpJ59zY24xlv/p
 BzQM7vM6gWqnxE8azEbBRl3Wz7QlAVuCVmhm1j5vue6sQKy2dcHzUyIpR3bp3SNFyBTu
 QPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pVMLjmysx/GAxoOSlchhJrjzKdlg8+FB1XEtBsIhF8M=;
 b=HIzLwbpvmt8AZc5LtuvYSA/fH224qOnNS9GIGPQdBg9yam6ZthKwPAwtbX+CRNot4a
 EQLEgWpInZhmWPCrFMbIT/BVry94Q611lShWY9v68+gRth662PL2uo0HXoDp5bD1OsBX
 n2wxQb8pfZcwyyeBQjNn7hqRRyqpwXRA38EkGSJaYuFPA2eVT9CsLJzNgDycqE7iI6zo
 YISpPK45G8xNSzn9YDK7ABAu6+A1Bqoo0A6K+yHXb25zYNCYUES5mPmrNWAHqqOS+Rsx
 zEhQ/P0yR04ucGpgag6RdusHazgsOLsNB50iVSVLgz5UFdKumHsbUxDsVWCY2vS6PR7k
 9lnQ==
X-Gm-Message-State: APjAAAXr1Z0oDCn33iaNrcFFrzn/TqbczBN96M1G53nQB6OloLvnPp/0
 tHMzD8xfl/hzd1fpFyxbj0I=
X-Google-Smtp-Source: APXvYqwc98X776mZ7k9NpFB6Z5/tUNJntzntVheNgoz3ACePgi9lBMH9/FuRuLRWGRwSKLaiYMrDcQ==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr13549930wmi.37.1579433782577; 
 Sun, 19 Jan 2020 03:36:22 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id y22sm17523924wma.35.2020.01.19.03.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 03:36:21 -0800 (PST)
Subject: Re: [Qemu-devel] What should a virtual board emulate?
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
 <6b5459b5-deb2-e70c-deab-fa7246b43e38@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <36d5b922-b134-a5f4-8d9e-1ea3d87daedc@amsat.org>
Date: Sun, 19 Jan 2020 12:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6b5459b5-deb2-e70c-deab-fa7246b43e38@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/18/20 9:46 PM, Paolo Bonzini wrote:
> On 04/01/20 22:16, Philippe Mathieu-Daudé wrote:
>> 1/ the Radeon chip is soldered on the motherboard,
>>
>> 2/ the default BIOS expects the Radeon chip to be
>>    unconditionally present,
>>
>> I insist this patch is incorrect for the particular case of the
>> Fuloong2e board. I plan to revert it when I post the test.
>>
>> BTW I'm not using --nodefault, I'm running default ./configure:
>>
>> qemu-system-mips64el -M fulong2e -bios pmon_2e.bin \
>> -display none -vga none -serial stdio
> 
> But if you're not specifying -nodefaults, why are you specifying a
> configuration that your BIOS does not support?  You should just remove
> -vga none and leave in -display none.

OK, with this information I searched what enforcing -vga none, with:

$ git grep -- -vga.*none python/
python/qemu/machine.py:232:        args = ['-display', 'none', '-vga',
'none']

Context:

 61 class QEMUMachine(object):
...
230
231     def _base_args(self):
232         args = ['-display', 'none', '-vga', 'none']
...
290     def launch(self):
301         try:
302             self._launch()
...
314     def _launch(self):
315         """
316         Launch the VM and establish a QMP connection
317         """
318         devnull = open(os.path.devnull, 'rb')
319         self._pre_launch()
320         self._qemu_full_args = (self._wrapper + [self._binary] +
321                                 self._base_args() + self._args)

Except the refactors moving this code, the original commit is:

$ git show 0fd05e8dd1e
commit 0fd05e8dd1ee7ae143fba3d6bcc6abe3fbeaeb34
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Jun 6 16:23:27 2012 +0200

    qemu-iotests: start vms in qtest mode

    This way, they will not execute any VM code at all.  However, right now
    the cancellation test is "relying" on being slowed down by TCG executing
    BIOS code.  So, change the timeouts.

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Kevin Wolf <kwolf@redhat.com>

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index e27b40e289..e05b1d640b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -54,7 +54,9 @@ class VM(object):
         self._qemu_log_path = os.path.join(test_dir, 'qemu-log.%d' %
os.getpid())
         self._args = qemu_args + ['-chardev',
                      'socket,id=mon,path=' + self._monitor_path,
-                     '-mon', 'chardev=mon,mode=control', '-nographic']
+                     '-mon', 'chardev=mon,mode=control',
+                     '-qtest', 'stdio', '-machine', 'accel=qtest',
+                     '-display', 'none', '-vga', 'none']
         self._num_drives = 0

     def add_drive(self, path, opts=''):

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 4ab7d62961..cc671dd7aa 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -147,7 +147,7 @@ class TestStreamStop(ImageStreamingTestCase):
         result = self.vm.qmp('block-stream', device='drive0')
         self.assert_qmp(result, 'return', {})

-        time.sleep(1)
+        time.sleep(0.1)
         events = self.vm.get_qmp_events(wait=False)
         self.assertEqual(events, [], 'unexpected QMP event: %s' % events)

So IIUC we need to rework a bit the defaults of QEMUMachine::base_args.

