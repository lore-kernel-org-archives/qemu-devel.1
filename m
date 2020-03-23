Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B19C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EFC20753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKpbv/fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EFC20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34869 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGONB-00007z-17
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jGOLG-00064o-DM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jGOLF-0001Fr-6T
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:46:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jGOLF-0001Fk-1t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584974772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bq/qMCEDRBtHrycFFa0eqvFbhbbxHXYnkWVuyjN+TmA=;
 b=iKpbv/fvMH7Rm2imQiOClQZk7rBJi+/DyaS1auqeOjtICb01f7WgeFrp2YAwVxVBp641tn
 GJ3oJNCp0Wy4+qYs4IIk9eeuCAHYAgoqIIgy31mw+ob7V25IgTCAqdmKiMeMalmjuHv47D
 Ni8DTxuk0pXzReeuVyWARfx5WlXcviI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Zhxtoe45MoCMKjQbZy2qMQ-1; Mon, 23 Mar 2020 10:46:10 -0400
X-MC-Unique: Zhxtoe45MoCMKjQbZy2qMQ-1
Received: by mail-vk1-f197.google.com with SMTP id q65so5249904vka.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 07:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3We6DcaiUowceXNyyKIGcg8niQTii8dUv2RcndUIbEE=;
 b=FwwjYt5J7eDQWhop+pilhhhV2cVS63gLURaDrndFOoClBrmr2W4IwA/GJ90UswcwzE
 hUNJFw4+P9K3wSmE6RO7SWcPvs2w2mFYDEDOe9v+vR9GpOpbIpeMHw+req7GNFdFQGFu
 fPlOkEl86129UEAgXN44YQ3eCau/IEeZFTKJx8EVJpDi7pR3x/th+HsXJQkA15RHPwkj
 COVi3UV3vjL+1Z173RB7C0M3pCpfQz5j+SGGm1hMVHBBvqd9eW2EXsIW0VMkxD+eTG0M
 REq/OzUQjW4gbFsrk4ibypmCCyp2BmzET2mMe59g2bnydQALuBMs/lTQAd20vPj5UXyD
 2qbA==
X-Gm-Message-State: ANhLgQ2IsywB1m2nWPfJVFACCjBUUVbxZT13eAn504QPjM8S7W073P3v
 P7s9VLjXMWohcTBAoEx6LFUVIkl2VYraM7UCQrL0dUe4HhOAagKvnEfwmLn+CoprlfrJ6AABSfd
 lc5nZPjmxke5EXG0CTOQiugwDU8MD3Q0=
X-Received: by 2002:a05:6102:758:: with SMTP id
 v24mr5136401vsg.28.1584974770216; 
 Mon, 23 Mar 2020 07:46:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQ16rUnXy0VCLJz4nl764qQJpWIXDmsxp1Hwig0+hoUhyib9Q+Teoo3FfZ+SjP719vBlQg3c/mSyfdY8SzQl4=
X-Received: by 2002:a05:6102:758:: with SMTP id
 v24mr5136382vsg.28.1584974769970; 
 Mon, 23 Mar 2020 07:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200323103016.17368-1-ovoshcha@redhat.com>
 <20200323103016.17368-2-ovoshcha@redhat.com>
In-Reply-To: <20200323103016.17368-2-ovoshcha@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 23 Mar 2020 11:45:58 -0300
Message-ID: <CAKJDGDbVsnA2hstY_wQPnpkPoV2Vaf6wumMg==gpiOChh9BL3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] Acceptance test: adds param 'address' in
 _get_free_port
To: Oksana Vohchana <ovoshcha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer Moschetta <wainersm@redhat.com>, Cleber Rosa Junior <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 7:30 AM Oksana Vohchana <ovoshcha@redhat.com> wrote=
:
>
> In the migration test function _get_free_port works only for localhost,
> but in the case to use migration through an RDMA we need to get a free po=
rt
> on the configured network RDMA-interface.
> This patch is the start for another migration option
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>  tests/acceptance/migration.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a8367ca023..e4c39b85a1 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -52,8 +52,8 @@ class Migration(Test):
>          source_vm.qmp('migrate', uri=3Dsrc_uri)
>          self.assert_migration(source_vm, dest_vm)
>
> -    def _get_free_port(self):
> -        port =3D network.find_free_port()
> +    def _get_free_port(self, address=3D'localhost'):
> +        port =3D network.find_free_port(address=3Daddress)
>          if port is None:
>              self.cancel('Failed to find a free port')
>          return port
> --
> 2.21.1
>

Just confirming,

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


