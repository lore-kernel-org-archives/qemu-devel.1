Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E110C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4670F22CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccY1tJ01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4670F22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i168g-0001X9-Ez
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i167s-0000oQ-N6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i167p-0004QJ-9x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:44:56 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i167j-0004JZ-Uf; Fri, 23 Aug 2019 05:44:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id y8so6549390oih.10;
 Fri, 23 Aug 2019 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=5khhwLdTUzd4zj+bV+ZHTZ6XOoMItgHvmQkOqcekUPU=;
 b=ccY1tJ01PcA8T8iH/0rdM/FZzYkzShwy8Kf2YWssrAKyYJRIs1nONOwi9wqK0Usfxc
 9a6VxWZm5Wo94S/BmRJWrRo2bwk945CEcNPQAqtYKfTjYerO2qghnKY5k62iCl+u4qAs
 6TvM0QFVvDmHY+Yt1HkSsqJu+ghVY4NTnWMkL3Q/jezohmzkzw42AfK1m9ZjFOwnkpV3
 eqWNd9tX/9AGkILkcKomfniKp8M5UiPCZUaIAZty94Fdw5Y2GpXaTFugQYnbjV42QtF8
 URNYjGlLAFRgqTlUnzlfYHF+ael28cwgtA4fBckCnLRP/uu2KyaUf24FD4HRZB0atwDR
 Ibrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=5khhwLdTUzd4zj+bV+ZHTZ6XOoMItgHvmQkOqcekUPU=;
 b=UmWOr8Xb1ZPztsxQN7zm/kt6tzyItfcfn5/WOeuIPIFygFcDOoh8XQxybUZTa0wAcv
 asD7I9qrDqg9RzWqO2TZVYgcZ9A/Ckyi4fprPb/0vsx+uMynLI4WZ1ltCWQYrSnu7Zfn
 6uax95oVmM9rOVyvgTV+wAT/BvVOBGrAm58IDjILrR5wVR0TPjFwbW490z59R/fWxyjt
 9gTpPTuRKjKSNNaQuG6wY48ipDmvLUlnsXX29pQwgjnNjFistq78Wwq/ubeGDqKsHMxK
 fdz8IEqx9kley8s+1McOo5lHg7tOks/D4qBEAt1NOxq9pDGcTXpGwzvG/8t8Mxj9WoDH
 e9qw==
X-Gm-Message-State: APjAAAV9+FYoQuqMUZTi74HZXJFENyuKB6gStgwKljRkSXLa8Itx9Y1E
 +bzuhyZUt9Pe1o9eeCxHzmvFNI73SPDxDQHz0VQ=
X-Google-Smtp-Source: APXvYqyCwcKf0qBaCmWgTief56/pgGOVuNo0Xp3TjK6+9BTHH1ziiYjDSGCbLuGX+WwCPnAbvaVrc6E4bkHfPW1C6tk=
X-Received: by 2002:aca:4083:: with SMTP id n125mr2365844oia.106.1566553487181; 
 Fri, 23 Aug 2019 02:44:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 02:44:46
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 02:44:46
 -0700 (PDT)
In-Reply-To: <20190822230916.576-4-philmd@redhat.com>
References: <20190822230916.576-1-philmd@redhat.com>
 <20190822230916.576-4-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 23 Aug 2019 11:44:46 +0200
Message-ID: <CAL1e-=hypCsXVMhU5nC8O7JuDHN89huaMSe5RrJ27YB9W+AK_g@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 3/3] mailmap: Add many entries to improve
 'git shortlog' statistics
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2019. 01.10, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> All of these emails have a least 1 commit with utf8/latin1 encoding
> issue, or one with no author name.
> When there are multiple commits, keep the author name the most used.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Out of the scope of this patch, what about the cases like Mateja
Marjanovic, who contributed with both Mateja.Marjanovic@rt-rk.com and
mateja.marjanovic@rt-rk.com ?

>  .mailmap | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/.mailmap b/.mailmap
> index e68ddd26e6..d0fc1d793c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -37,5 +37,110 @@ Yongbok Kim <yongbok.kim@mips.com> <
yongbok.kim@imgtec.com>
>
>  # Also list preferred name forms where people have changed their
>  # git author config, or had utf8/latin1 encoding issues.
> +Aaron Lindsay <aaron@os.amperecomputing.com>
> +Alexey Gerasimenko <x1917x@gmail.com>
> +Alex Ivanov <void@aleksoft.net>
> +Andreas F=C3=A4rber <afaerber@suse.de>
> +Bandan Das <bsd@redhat.com>
> +Benjamin MARSILI <mlspirat42@gmail.com>
> +Beno=C3=AEt Canet <benoit.canet@gmail.com>
> +Beno=C3=AEt Canet <benoit.canet@irqsave.net>
> +Beno=C3=AEt Canet <benoit.canet@nodalink.com>
> +Boqun Feng <boqun.feng@gmail.com>
> +Boqun Feng <boqun.feng@intel.com>
> +Brad Smith <brad@comstyle.com>
> +Brijesh Singh <brijesh.singh@amd.com>
> +Brilly Wu <brillywu@viatech.com.cn>
> +C=C3=A9dric Vincent <cedric.vincent@st.com>
> +CheneyLin <linzc@zju.edu.cn>
> +Chen Gang <chengang@emindsoft.com.cn>
> +Chen Gang <gang.chen.5i5j@gmail.com>
> +Chen Gang <gang.chen@sunrus.com.cn>
> +Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
> +Christophe Lyon <christophe.lyon@st.com>
> +Collin L. Walling <walling@linux.ibm.com>
>  Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> +Eduardo Otubo <otubo@redhat.com>
> +Fabrice Desclaux <fabrice.desclaux@cea.fr>
> +Fernando Luis V=C3=A1zquez Cao <fernando_b1@lab.ntt.co.jp>
> +Fernando Luis V=C3=A1zquez Cao <fernando@oss.ntt.co.jp>
> +Gautham R. Shenoy <ego@in.ibm.com>
> +Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> +Gonglei (Arei) <arei.gonglei@huawei.com>
> +Guang Wang <wang.guang55@zte.com.cn>
> +Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> +Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> +Jakub Jerm=C3=A1=C5=99 <jakub@jermar.eu>
> +Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
> +Jean-Christophe Dubois <jcd@tribudubois.net>
> +Jind=C5=99ich Makovi=C4=8Dka <makovick@gmail.com>
> +John Arbuckle <programmingkidx@gmail.com>
> +Juha Riihim=C3=A4ki <juha.riihimaki@nokia.com>
> +Juha Riihim=C3=A4ki <Juha.Riihimaki@nokia.com>
> +Jun Li <junmuzi@gmail.com>
> +Laurent Vivier <Laurent@lvivier.info>
> +Leandro Lupori <leandro.lupori@gmail.com>
> +Li Guang <lig.fnst@cn.fujitsu.com>
> +Liming Wang <walimisdev@gmail.com>
> +linzhecheng <linzc@zju.edu.cn>
> +Liran Schour <lirans@il.ibm.com>
> +Liu Yu <yu.liu@freescale.com>
> +Liu Yu <Yu.Liu@freescale.com>
> +Li Zhang <zhlcindy@gmail.com>
> +Li Zhang <zhlcindy@linux.vnet.ibm.com>
> +Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> +Llu=C3=ADs Vilanova <xscript@gmx.net>
> +Longpeng (Mike) <longpeng2@huawei.com>
> +Luc Michel <luc.michel@git.antfield.fr>
> +Luc Michel <luc.michel@greensocs.com>
> +Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
> +Marc Mar=C3=AD <markmb@redhat.com>
> +Michael Avdienko <whitearchey@gmail.com>
> +Michael S. Tsirkin <mst@redhat.com>
> +Munkyu Im <munkyu.im@samsung.com>
> +Nicholas Bellinger <nab@linux-iscsi.org>
> +Nicholas Thomas <nick@bytemark.co.uk>
> +Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> +Orit Wasserman <owasserm@redhat.com>
> +Paolo Bonzini <pbonzini@redhat.com>
> +Pavel Dovgaluk <dovgaluk@ispras.ru>
> +Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
> +Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
> +Peter Crosthwaite <crosthwaite.peter@gmail.com>
> +Peter Crosthwaite <peter.crosthwaite@petalogix.com>
> +Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> +Prasad J Pandit <pjp@fedoraproject.org>
> +Prasad J Pandit <ppandit@redhat.com>
> +Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
>  Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
> +Remy Noel <remy.noel@blade-group.com>
> +Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> +Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
> +Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> +Sochin Jiang <sochin.jiang@huawei.com>
> +Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> +Thomas Huth <thuth@redhat.com>
> +Thomas Knych <thomaswk@google.com>
> +Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
> +Tony Nguyen <tony.nguyen@bt.com>
> +Venkateswararao Jujjuri <jvrao@linux.vnet.ibm.com>
> +Vibi Sreenivasan <vibi_sreenivasan@cms.com>
> +Vijaya Kumar K <vijayak@cavium.com>
> +Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> +Vijay Kumar <vijaykumar@bravegnu.org>
> +Vijay Kumar <vijaykumar@zilogic.com>
> +Wang Guang <wang.guang55@zte.com.cn>
> +Wenchao Xia <xiawenc@linux.vnet.ibm.com>
> +Wenshuang Ma <kevinnma@tencent.com>
> +Xiaoqiang Zhao <zxq_yx_007@163.com>
> +Xinhua Cao <caoxinhua@huawei.com>
> +Xiong Zhang <xiong.y.zhang@intel.com>
> +Yin Yin <yin.yin@cs2c.com.cn>
> +yuchenlin <npes87184@gmail.com>
> +YunQiang Su <syq@debian.org>
> +YunQiang Su <ysu@wavecomp.com>
> +Yuri Pudgorodskiy <yur@virtuozzo.com>
> +Zhengui Li <lizhengui@huawei.com>
> +Zhenwei Pi <pizhenwei@bytedance.com>
> +Zhenwei Pi <zhenwei.pi@youruncloud.com>
> +Zhuang Yanying <ann.zhuangyanying@huawei.com>
> --
> 2.20.1
>
>
