Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AFFC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048772087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTvJtT7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048772087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3Fs-00012Y-4T
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz3B7-00019T-4g
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz3B4-0001Iy-SP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:44:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz3B4-0001H5-OF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580841842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=msaZ0sE2Bj0NZ0bsTzY0GDVNGQxjNF3J3LnjRUgJ8TA=;
 b=aTvJtT7sukMfYxlG+bccsMtARqQdF7IG05TzncwwrRLiDZ4TcihmTXWv8ebs2v/uabVw84
 smgyofzATllwMqConm2fRqMNQ0dd2KlNh9eePkNnr6PO/sFa632x6hAwoRM61h4IZXxpAV
 xEHJ2YpZFiyLXhyAKKgryTc5sZA1BEI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-J5SsuFujNkSmdpz7tO4kQg-1; Tue, 04 Feb 2020 13:43:59 -0500
Received: by mail-wm1-f69.google.com with SMTP id b202so1856863wmb.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b7yQ41U6FDyAIELOpak0CVYy8imSizYpuoN48Jn5zW4=;
 b=cZRxoBEAPNh7LfI2OUu9o1qM4DbQEWcKM2KMqNra3sDxjJ+jhFz8d9ehrIQ2xYPMfN
 ZxMl2EmveOe1UNgLCbyxqE3uOoUWt/Ax705uBJOFysGu8qnEvYlQA3GLqn4bw4ZeHZos
 zvZdtvF+6wmQxqdpHgaYmeW8GC49CZ5fNlQHdTG7kWKrK3SxE5W89RXoCx6GwjIUMLGf
 MnfbjxTCFCGwsx4R856aKz0zlzjq6uKIDN0W2VV5+ltZlBVQP/le4/79DYAQxOodotAF
 rwhRqiruL0OueHGN9+o10euB/Z5ikKDmTKttI61PTfT8n2xYaj3EiWh1gI2Dh/1kU+T5
 5zEA==
X-Gm-Message-State: APjAAAVmtgUcE0y+WrK75XQ0USpReMlJlh+FP1OYHw05RKZHjfB/wZht
 /n3X5MDYrLnobhF3U4nU85ayy924aq+q3EHGV2MMrkc7CgiO0Hx7YW8feeV2rhIOFoJ/xOeE4uy
 OF1QTB+5EYxiYbn8=
X-Received: by 2002:a05:600c:291e:: with SMTP id
 i30mr444163wmd.40.1580841838202; 
 Tue, 04 Feb 2020 10:43:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHV/jg+jtpa93E+4Y1yGeka8ekLdezaqI6tqdbfKgAkz8W4+lgcADePFSZ9M6noyMhB840oA==
X-Received: by 2002:a05:600c:291e:: with SMTP id
 i30mr444145wmd.40.1580841837986; 
 Tue, 04 Feb 2020 10:43:57 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id y139sm4902484wmd.24.2020.02.04.10.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 10:43:57 -0800 (PST)
Subject: Re: [PATCH v2] mailmap: Add more entries to sanitize 'git log' output
To: qemu-trivial@nongnu.org
References: <20200118143202.29187-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6d85e2c-33bc-d479-2555-668a2d55df72@redhat.com>
Date: Tue, 4 Feb 2020 19:43:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200118143202.29187-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: J5SsuFujNkSmdpz7tO4kQg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Marek Dolata <mkdolata@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 1/18/20 3:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Most of these developers have the Signed-off-by tag properly
> written, but not the author/committer name. Fix this.
> Also we incorrectly wrote Arei Gonglei name, update and reorder.
>=20
> The committer name/email is displayed when using:
>=20
>    $ git log --format=3Dfuller
>=20
> (which can be set in git-config setting format.pretty=3Dfuller).
>=20
> Example of commits with miswritten committer email:
>    3b08098b40 76349f5ba8 eb83c2030a 572992eefa 0d4abda8f7
>=20
> Note: git-log does not use this file by default until you specify
> the --use-mailmap flag:
>=20
>    $ git log --use-mailmap
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2:
> - Added Marek Dolata (commit 5a07192a0)
> - Describe git-log --format=3Dfuller
> - Added Markus R-b
> ---
>   .mailmap | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 3816e4effe..cf981a3ec0 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -56,6 +56,10 @@ Aaron Lindsay <aaron@os.amperecomputing.com>
>   Alexey Gerasimenko <x1917x@gmail.com>
>   Alex Ivanov <void@aleksoft.net>
>   Andreas F=C3=A4rber <afaerber@suse.de>
> +Andreas F=C3=A4rber <andreas.faerber@web.de>
> +Andreas F=C3=A4rber <andreas.faerber@web.de> <andreas.faerber>
> +Arei Gonglei <arei.gonglei@huawei.com>
> +Arei Gonglei <arei.gonglei@huawei.com> <root@ceth6.(none)>
>   Bandan Das <bsd@redhat.com>
>   Benjamin MARSILI <mlspirat42@gmail.com>
>   Beno=C3=AEt Canet <benoit.canet@gmail.com>
> @@ -67,27 +71,36 @@ Brad Smith <brad@comstyle.com>
>   Brijesh Singh <brijesh.singh@amd.com>
>   Brilly Wu <brillywu@viatech.com.cn>
>   C=C3=A9dric Vincent <cedric.vincent@st.com>
> +Chai Wen <chaiw.fnst@cn.fujitsu.com>
> +Chaojian Hu <chaojianhu@hotmail.com>
>   CheneyLin <linzc@zju.edu.cn>
> +Chen Fan <chen.fan.fnst@cn.fujitsu.com>
>   Chen Gang <chengang@emindsoft.com.cn>
>   Chen Gang <gang.chen.5i5j@gmail.com>
>   Chen Gang <gang.chen@sunrus.com.cn>
>   Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
>   Christophe Lyon <christophe.lyon@st.com>
> +Christoph Hellwig <hch@lst.de>
>   Collin L. Walling <walling@linux.ibm.com>
>   Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> +Disheng Su <edison@cloud.com>
> +Dunrong Huang <riegamaths@gmail.com>
>   Eduardo Otubo <otubo@redhat.com>
>   Fabrice Desclaux <fabrice.desclaux@cea.fr>
>   Fernando Luis V=C3=A1zquez Cao <fernando_b1@lab.ntt.co.jp>
>   Fernando Luis V=C3=A1zquez Cao <fernando@oss.ntt.co.jp>
>   Gautham R. Shenoy <ego@in.ibm.com>
>   Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> -Gonglei (Arei) <arei.gonglei@huawei.com>
>   Guang Wang <wang.guang55@zte.com.cn>
>   Hailiang Zhang <zhang.zhanghailiang@huawei.com>
>   Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> +Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
>   Jakub Jerm=C3=A1=C5=99 <jakub@jermar.eu>
>   Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
> +Jay Zhou <jianjay.zhou@huawei.com>
>   Jean-Christophe Dubois <jcd@tribudubois.net>
> +Jean-Christophe Dubois <jcd@tribudubois.net> <jcd@jcd-laptop.(none)>
> +Jia Lina <jialina01@baidu.com>
>   Jind=C5=99ich Makovi=C4=8Dka <makovick@gmail.com>
>   John Arbuckle <programmingkidx@gmail.com>
>   Juha Riihim=C3=A4ki <juha.riihimaki@nokia.com>
> @@ -96,9 +109,11 @@ Jun Li <junmuzi@gmail.com>
>   Laurent Vivier <Laurent@lvivier.info>
>   Leandro Lupori <leandro.lupori@gmail.com>
>   Li Guang <lig.fnst@cn.fujitsu.com>
> +Lili Huang <huanglili.huang@huawei.com>
>   Liming Wang <walimisdev@gmail.com>
>   linzhecheng <linzc@zju.edu.cn>
>   Liran Schour <lirans@il.ibm.com>
> +Li Tianqing <tianqing@unitedstack.com>
>   Liu Yu <yu.liu@freescale.com>
>   Liu Yu <Yu.Liu@freescale.com>
>   Li Zhang <zhlcindy@gmail.com>
> @@ -110,13 +125,17 @@ Luc Michel <luc.michel@git.antfield.fr>
>   Luc Michel <luc.michel@greensocs.com>
>   Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
>   Marc Mar=C3=AD <markmb@redhat.com>
> +Marek Dolata <mkdolata@us.ibm.com>
>   Michael Avdienko <whitearchey@gmail.com>
>   Michael S. Tsirkin <mst@redhat.com>
> +Michael S. Tsirkin <mst@redhat.com> <mst@robin.(none)>
> +Michael Tokarev <mjt@tls.msk.ru> <mjt@gandalf>
>   Munkyu Im <munkyu.im@samsung.com>
>   Nicholas Bellinger <nab@linux-iscsi.org>
>   Nicholas Thomas <nick@bytemark.co.uk>
>   Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>   Orit Wasserman <owasserm@redhat.com>
> +Pan Nengyuan <pannengyuan@huawei.com>
>   Paolo Bonzini <pbonzini@redhat.com>
>   Pavel Dovgaluk <dovgaluk@ispras.ru>
>   Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
> @@ -124,15 +143,23 @@ Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
>   Peter Crosthwaite <crosthwaite.peter@gmail.com>
>   Peter Crosthwaite <peter.crosthwaite@petalogix.com>
>   Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> +Peter Maydell <peter.maydell@linaro.org> <petmay01@cam-vm-266.(none)>
>   Prasad J Pandit <pjp@fedoraproject.org>
>   Prasad J Pandit <ppandit@redhat.com>
>   Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
>   Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
>   Remy Noel <remy.noel@blade-group.com>
> +Richard Henderson <rth@twiddle.net> <rth@anchor.twiddle.home>
>   Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>   Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
>   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> +Siwei Zhuang <Siwei.Zhuang@data61.csiro.au>
> +Sochin Jiang <sochin@aliyun.com>
>   Sochin Jiang <sochin.jiang@huawei.com>
> +Stefan Berger <stefanb@linux.ibm.com> <Stefan Berger stefanb@linux.vnet.=
ibm.com>
> +Stefan Weil <sw@weilnetz.de> <stefan@kiwi.(none)>
> +Stefan Weil <sw@weilnetz.de> <stefan@weilnetz.de>
> +Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
>   Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>   Thomas Huth <thuth@redhat.com>
>   Thomas Knych <thomaswk@google.com>
> @@ -150,6 +177,7 @@ Wenshuang Ma <kevinnma@tencent.com>
>   Xiaoqiang Zhao <zxq_yx_007@163.com>
>   Xinhua Cao <caoxinhua@huawei.com>
>   Xiong Zhang <xiong.y.zhang@intel.com>
> +Ying Fang <fangying1@huawei.com>
>   Yin Yin <yin.yin@cs2c.com.cn>
>   yuchenlin <npes87184@gmail.com>
>   YunQiang Su <syq@debian.org>
>=20


