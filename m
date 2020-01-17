Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A01AC3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159802087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwoOdG4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159802087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUss-0003rY-5q
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:54:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1isUrw-0002na-UE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1isUrs-0002Wi-UT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:53:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1isUrs-0002V5-Qv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579279988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0s1e3wFZuSI2imvfqdX57mYUhYsVNZnyzDn5sVcg1E=;
 b=QwoOdG4NRcKFK5UslBNX/wTB+RK4OfwPtNetfPb1RXGldO+jQvSB6Hd9rl15REGbsMACLP
 w+zMlvAdGEnkrCN1FjRFGF9OTu4mbI8TY/RfRAAUCydE/gC23t3zkdQndCemTbLh9/SQSc
 acOVW9WLZvLBrDdEKeAdj5M3RwCuBo0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-GArx0gaJOJW2YU5AsEzGfg-1; Fri, 17 Jan 2020 11:53:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id o6so10687083wrp.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 08:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R0s1e3wFZuSI2imvfqdX57mYUhYsVNZnyzDn5sVcg1E=;
 b=oUwqYFK9ipQY3W3/FxtTE5DQTAN/OzUPwMy8fA653dqcdFe9mMzuP6hDhnExndlA/P
 U6P5SBuDlid9Ku3tNfaTLmA/Vc5VLWXYbbMZQ53P8jt+uUkKTPDTkntjhBbvJNwaTb2L
 9lXQ4HvrBlRBlYiEdM45g5SwF7seFpKrdZVG0EK1BwKtIy6XCp3MI+7K32DQuHtCwlTk
 0p4U4B5j0avRqhIP3XiFqio0h484qlXqELyIRQP8Hxq/POzX+YqmcLCTb3vqbySYnb1P
 xp/af0oY/f4GAVDYBhB6Ut8XCKpFKmbU7odlFnmVrgqX+v6xjo1DXJJI6lZcUvEti9Sj
 R08A==
X-Gm-Message-State: APjAAAV2Xdeb2kzd8x7sKE/plp3XfqFj8HY3Wev51GBrsRv985TG0Msg
 lQxFbLE0mphxsZwmlu8uTMZuZHJs4hm/PpVGjUXWNE3TIUSLxJQNXj3tFJ7bcgP2oRJb7sT59ho
 WmoKDuVDHYvXjbFOLIhyv9P3CX+t0BI8=
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr4244841wrl.117.1579279983254; 
 Fri, 17 Jan 2020 08:53:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcWtQin4vqaFBczq8lv2wKBnbOKg44p8M3NxW0ZY183aX4b1UNYq0jHC050n+rLkr84QSlvXdJrcyURQa13qU=
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr4244821wrl.117.1579279983046; 
 Fri, 17 Jan 2020 08:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20191218185723.7738-1-philmd@redhat.com>
In-Reply-To: <20191218185723.7738-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 17 Jan 2020 17:52:51 +0100
Message-ID: <CAP+75-UOLktsv95POJ_0_etdYGfonvJ_zub0VQv9eQA+W20o5A@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Add more entries to sanitize 'git log' output
To: QEMU Developers <qemu-devel@nongnu.org>
X-MC-Unique: GArx0gaJOJW2YU5AsEzGfg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On Wed, Dec 18, 2019 at 7:57 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Most of these developers have the Signed-off-by tag properly
> written, but not the author/commiter name. Fix this.
> Also we incorrectly wrote Arei Gonglei name, update and reorder.
>
> git-log does not use this file by default until you specify the
> --use-mailmap flag:
>
>   $ git log --use-mailmap
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .mailmap | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 3816e4effe..1a859d9e65 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -56,6 +56,10 @@ Aaron Lindsay <aaron@os.amperecomputing.com>
>  Alexey Gerasimenko <x1917x@gmail.com>
>  Alex Ivanov <void@aleksoft.net>
>  Andreas F=C3=A4rber <afaerber@suse.de>
> +Andreas F=C3=A4rber <andreas.faerber@web.de>
> +Andreas F=C3=A4rber <andreas.faerber@web.de> <andreas.faerber>
> +Arei Gonglei <arei.gonglei@huawei.com>
> +Arei Gonglei <arei.gonglei@huawei.com> <root@ceth6.(none)>
>  Bandan Das <bsd@redhat.com>
>  Benjamin MARSILI <mlspirat42@gmail.com>
>  Beno=C3=AEt Canet <benoit.canet@gmail.com>
> @@ -67,27 +71,36 @@ Brad Smith <brad@comstyle.com>
>  Brijesh Singh <brijesh.singh@amd.com>
>  Brilly Wu <brillywu@viatech.com.cn>
>  C=C3=A9dric Vincent <cedric.vincent@st.com>
> +Chai Wen <chaiw.fnst@cn.fujitsu.com>
> +Chaojian Hu <chaojianhu@hotmail.com>
>  CheneyLin <linzc@zju.edu.cn>
> +Chen Fan <chen.fan.fnst@cn.fujitsu.com>
>  Chen Gang <chengang@emindsoft.com.cn>
>  Chen Gang <gang.chen.5i5j@gmail.com>
>  Chen Gang <gang.chen@sunrus.com.cn>
>  Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
>  Christophe Lyon <christophe.lyon@st.com>
> +Christoph Hellwig <hch@lst.de>
>  Collin L. Walling <walling@linux.ibm.com>
>  Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> +Disheng Su <edison@cloud.com>
> +Dunrong Huang <riegamaths@gmail.com>
>  Eduardo Otubo <otubo@redhat.com>
>  Fabrice Desclaux <fabrice.desclaux@cea.fr>
>  Fernando Luis V=C3=A1zquez Cao <fernando_b1@lab.ntt.co.jp>
>  Fernando Luis V=C3=A1zquez Cao <fernando@oss.ntt.co.jp>
>  Gautham R. Shenoy <ego@in.ibm.com>
>  Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> -Gonglei (Arei) <arei.gonglei@huawei.com>
>  Guang Wang <wang.guang55@zte.com.cn>
>  Hailiang Zhang <zhang.zhanghailiang@huawei.com>
>  Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> +Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
>  Jakub Jerm=C3=A1=C5=99 <jakub@jermar.eu>
>  Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
> +Jay Zhou <jianjay.zhou@huawei.com>
>  Jean-Christophe Dubois <jcd@tribudubois.net>
> +Jean-Christophe Dubois <jcd@tribudubois.net> <jcd@jcd-laptop.(none)>
> +Jia Lina <jialina01@baidu.com>
>  Jind=C5=99ich Makovi=C4=8Dka <makovick@gmail.com>
>  John Arbuckle <programmingkidx@gmail.com>
>  Juha Riihim=C3=A4ki <juha.riihimaki@nokia.com>
> @@ -96,9 +109,11 @@ Jun Li <junmuzi@gmail.com>
>  Laurent Vivier <Laurent@lvivier.info>
>  Leandro Lupori <leandro.lupori@gmail.com>
>  Li Guang <lig.fnst@cn.fujitsu.com>
> +Lili Huang <huanglili.huang@huawei.com>
>  Liming Wang <walimisdev@gmail.com>
>  linzhecheng <linzc@zju.edu.cn>
>  Liran Schour <lirans@il.ibm.com>
> +Li Tianqing <tianqing@unitedstack.com>
>  Liu Yu <yu.liu@freescale.com>
>  Liu Yu <Yu.Liu@freescale.com>
>  Li Zhang <zhlcindy@gmail.com>
> @@ -112,11 +127,14 @@ Marc Mar=C3=AD <marc.mari.barcelo@gmail.com>
>  Marc Mar=C3=AD <markmb@redhat.com>
>  Michael Avdienko <whitearchey@gmail.com>
>  Michael S. Tsirkin <mst@redhat.com>
> +Michael S. Tsirkin <mst@redhat.com> <mst@robin.(none)>
> +Michael Tokarev <mjt@tls.msk.ru> <mjt@gandalf>
>  Munkyu Im <munkyu.im@samsung.com>
>  Nicholas Bellinger <nab@linux-iscsi.org>
>  Nicholas Thomas <nick@bytemark.co.uk>
>  Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>  Orit Wasserman <owasserm@redhat.com>
> +Pan Nengyuan <pannengyuan@huawei.com>
>  Paolo Bonzini <pbonzini@redhat.com>
>  Pavel Dovgaluk <dovgaluk@ispras.ru>
>  Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
> @@ -124,15 +142,23 @@ Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
>  Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  Peter Crosthwaite <peter.crosthwaite@petalogix.com>
>  Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> +Peter Maydell <peter.maydell@linaro.org> <petmay01@cam-vm-266.(none)>
>  Prasad J Pandit <pjp@fedoraproject.org>
>  Prasad J Pandit <ppandit@redhat.com>
>  Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
>  Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
>  Remy Noel <remy.noel@blade-group.com>
> +Richard Henderson <rth@twiddle.net> <rth@anchor.twiddle.home>
>  Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>  Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
>  Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> +Siwei Zhuang <siwei.zhuang@data61.csiro.au>
> +Sochin Jiang <sochin@aliyun.com>
>  Sochin Jiang <sochin.jiang@huawei.com>
> +Stefan Berger <stefanb@linux.ibm.com> <Stefan Berger stefanb@linux.vnet.=
ibm.com>
> +Stefan Weil <sw@weilnetz.de> <stefan@kiwi.(none)>
> +Stefan Weil <sw@weilnetz.de> <stefan@weilnetz.de>
> +Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
>  Takashi Yoshii <takasi-y@ops.dti.ne.jp>
>  Thomas Huth <thuth@redhat.com>
>  Thomas Knych <thomaswk@google.com>
> @@ -150,6 +176,7 @@ Wenshuang Ma <kevinnma@tencent.com>
>  Xiaoqiang Zhao <zxq_yx_007@163.com>
>  Xinhua Cao <caoxinhua@huawei.com>
>  Xiong Zhang <xiong.y.zhang@intel.com>
> +Ying Fang <fangying1@huawei.com>
>  Yin Yin <yin.yin@cs2c.com.cn>
>  yuchenlin <npes87184@gmail.com>
>  YunQiang Su <syq@debian.org>
> --
> 2.21.0
>


