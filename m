Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5AEC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 19:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E693206B5
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 19:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aPV0sj61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E693206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4rD6-0005uk-A5
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 15:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4r9y-00058k-9h
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 15:39:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:49053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4r9v-0002lA-5R
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 15:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597001936;
 bh=X9DS0lRJGUlf3kNMwaP27itgH/YNBWg2jZf3uw9A6b0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=aPV0sj61RoGUtNq47WwpYOZeXZTMZFQT5XvtmgR6ypB7pf4UptgM9mY8IvE1KoY71
 Yo1fmu0gS5cWqCkT82QX12vSX+4ah8C0BBORJxcg6pxvukWXebtH3HkG0g+ZZFcRWG
 /8ls9GUd9DMtzt515mcyXtLe+/Q/SPs9cIPbCWFY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.185.161]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1kVQTw0kam-00iBO6; Sun, 09
 Aug 2020 21:38:56 +0200
Subject: Re: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to avoid
 buffer over-run
To: Alexander Bulekov <alxndr@bu.edu>
References: <20200804140056.7690-1-deller@gmx.de>
 <20200804140056.7690-8-deller@gmx.de>
 <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
 <20200804212019.GA876@ls3530.fritz.box>
 <20200804220145.yjq265pk363466hx@mozz.bu.edu>
 <20200805204459.GA23951@ls3530.fritz.box>
 <20200806154556.ksb2ja3hghxhukdd@mozz.bu.edu>
 <01f10f58-1b29-d7f9-e4d5-6092d69aa127@gmx.de>
 <20200809171714.3qp72ubampclo4f2@mozz.bu.edu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <1d16f1cd-a57e-d56c-2e4f-09f594cc86b7@gmx.de>
Date: Sun, 9 Aug 2020 21:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200809171714.3qp72ubampclo4f2@mozz.bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:anbiY6FR6nxVMjHMfaB0hiViv1ui1Zm0Wj7KatUvddOzEiCd1k2
 D4cM4fJQ290wbsNFdoq1B2iCgmbBbSvOTtsp0nad0MJSsh5UO27eNLpAkKF4qyDQOCc20pM
 2gstbEM6WcuKct4G/RE0XLZ8Z4dAWPTEQVX6ZEckh1lMuxoqNgJXyANU9fpbVUTdioUyhJY
 34sGmsfjyelTXgPzw+yLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CO6Pclh/CbE=:BN6yqGGQ8UnbxtrtoLo54d
 ItEruoDN6uUV7L6hgOxBlLDYpyuKgZ5GzRZWurqvQeKaXbcslodi8RfD1aAgJkBO1J5tJxuK7
 Boy3cv2EMRWn7ZYbz+lfEW8frrzz0R3PW55TL+JBffTrnNVKRsm4VlX80SFIhAA7bwmoicNM0
 g7PMlAW5dDk1MdOvTRDmRYK2YJtOpgEy84FnjrG/Lno+vIfO/aemRjPoDomf3C9OGvDjOcxe7
 tgR3nOUxiFvIbGhPfwEy99O7btAay7UpOLWgL8/l91/CsbxJledcJz4T9UJEjgNQObKHhYjrZ
 n7R2pF0+bUbeC/Cfouqvpj7NEIHk/5pZaiWfU4cTbnsbvdSS8xzjdcmtA13/CY1C0m60bl1Cn
 xICQdOb0ndmVj3IBXbRq/no7hmmxW5ij21Yge874inNHYSz/0OgQ2tystQlfj6M7f0PLn0DNn
 dZZoyC9UtbXjab5Dcf19iiRm3e6TSJp+7xAGUKD01BibxX/MAATTli7HoESzQux7vxD8LlZJ9
 BQTj568BlMv/fuTV6o7HK3kktDMuroCircGJJKVHB2eGC+kLAEGECQyCl1ivxPnWjlqEPJjHu
 GbAcTsNs6A87kAGZymLNcWdoMYKTXvOLY94ynqiTGJe0Ny9wiAW/qpKk4y/js/IPQmGy0SJ3s
 LHnIcPTMjZBDjQWJQWIdVB6g5N3I56W1WfSF2RyDxTvCwwQNuFv521a9pgEtijXI7Vz+Y5YBs
 42qHEKJS/iA40Ah4A+4dIoX/GXBJfW1znp7kkgtU7bX+M8J88EY0fwwqYvU+LwHbYyXU/d9x4
 jzpvZ7899mPfc5ua1iTLlZopoSKWmBFssOw9+BC+1xTs20w6boVAeyXHkG41WPBSa8g9C7LLm
 AIWlC5pbptGYKSeHxv06pDICCv93CXV9PBTKnW/eBFwKjZw9pdrl+sWTZJ18TnuI8KvFMwE45
 Hs6DZpH2MfgOIOruTXKPnXkIkvHvBnKhPWhpInDtmcxZwJYlERPMs4igVgPzisZ1X+d2jxwsH
 1kqu6nXcVd/+pKwv8fTINGr9xETnrVUC+iA2cvkSNHY6z0c6J+Onn+tIP7aeryBVGG3SpdUpZ
 n+YUEwnHbRdjoWmx2LHD//+hEbCDqKFdz1ceG09P5yzn3nmGc19r0YKhAAfWS/zREOy44Ll+n
 sKft0BChk+HvrY3+mTPA/BrdjJc9vg2/mJq9F+Dch9IKMwcNCipdQ2h6SVk4QsHiq++0SP4Wr
 uJJR9bRx1HZEElPCb
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 15:39:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09.08.20 19:17, Alexander Bulekov wrote:
> On 200809 0717, Helge Deller wrote:
>> Hello Alexander,
>>
>> On 06.08.20 17:46, Alexander Bulekov wrote:
>>> On 200805 2244, Helge Deller wrote:
>>>> * Alexander Bulekov <alxndr@bu.edu>:
>>>>> On 200804 2320, Helge Deller wrote:
>>>>>> * Alexander Bulekov <alxndr@bu.edu>:
>>>>>>> I applied this series and it fixes most of the problems I saw befo=
re.
>>>>>>> I still see a few crashes - I made issues for them on launchpad:
>>>>>>> https://bugs.launchpad.net/qemu/+bug/1890310
>>>>>>> https://bugs.launchpad.net/qemu/+bug/1890311
>>>>>>> https://bugs.launchpad.net/qemu/+bug/1890312
>>>>> Hi Helge, I can still reproduce this one  ^^^
>>>>> I'll fuzz it some more, but so far I am not finding anything else.
>>>>
>>>> I've now updated the patch which does address all issues you found
>>>> so far. It's attached below.
>>>>
>>> I pulled from your repo, but I can still reproduce LP1890312
>>> (I build with --enable-sanitizers). Maybe I am missing something? With
>>> this cleared up, I'm happy to leave an Acked-by for the artist patches
>>> in this series.
>>>
>>> git show --summary
>>> commit 1657a7a95adc15552138c2b4d310a06128093892 (HEAD, hppa/target-hpp=
a, target-hppa)
>>> Author: Helge Deller <deller@gmx.de>
>>> Date:   Tue Aug 4 15:35:38 2020 +0200
>>
>> The current tree at
>> https://github.com/hdeller/qemu-hppa/commits/target-hppa
>> does survive all your tests and in addition fixes an artist bug which
>> made the dtwm window manager rendering wrong on HP-UX.
>> Please completely revert your tree before pulling again.
>> I'll send out a complete patch series shortly.
>>
>
> Hi Helge,
> This still causes a segfault for me:
>
> cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
> -qtest stdio -accel qtest
> writew 0xf8118001 0x105a
> readq 0xf900f8ff
> EOF

It's strange, I don't know why, but I can't reproduce it:
[deller@ls3530 qemu-helge-system]$ cat << EOF | ./hppa-softmmu/qemu-system=
-hppa -m 64 -display none -qtest stdio -accel qtest
writew 0xf8118001 0x105a
readq 0xf900f8ff
EOF
[I 1596999589.838131] OPENED
[R +0.006113] writew 0xf8118001 0x105a
OK
[S +0.006128] OK
[R +0.006137] readq 0xf900f8ff
OK 0x0000000000000000
[S +0.006141] OK 0x0000000000000000
[I +0.006163] CLOSED


Nevertheless, you are correct that there is a bounds check missing!

> I think the problem is that there is a bounds check missing on the
> artist_vram_read with s->cmap_bm_access path. The bounds check is
> present for artist_vram_write, so I just copied it over, and that fixed
> the issue (applied on top of the current qemu-hppa/target-hppa):

I'll apply it with minor modifications...

>
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 720db179ab..678023bb3a 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -1216,8 +1216,10 @@ static uint64_t artist_vram_read(void *opaque, hw=
addr addr, unsigned size)
>
>      if (s->cmap_bm_access) {
>          buf =3D &s->vram_buffer[ARTIST_BUFFER_CMAP];
> -        val =3D *(uint32_t *)(buf->data + addr);
> -        trace_artist_vram_read(size, addr, 0, 0, val);
> +        if (addr + 3 < buf->size) {

We need to check addr < buf->size too, otherwise with addr =3D 0xffffffff =
would succeed too:
	    if (addr < buf->size && addr + 3 < buf->size) {

> +            val =3D *(uint32_t *)(buf->data + addr);
> +            trace_artist_vram_read(size, addr, 0, 0, val);
> +        }
>          return 0;

This seems wrong... should be "return val;", otherwise the whole function
doesn't make sense.

Thank you!
Helge

