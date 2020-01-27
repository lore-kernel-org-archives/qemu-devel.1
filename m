Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6488DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2B920702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJIAIu9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2B920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3lP-0005Lt-BI
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iw3kl-0004na-Tx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iw3kk-0004ja-K4
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:44:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iw3kk-0004ik-Gm
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580129068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=YN3k8eIEEHeMJitCKfX/pS3BAEPaUOHd62mrG2iPfcY=;
 b=VJIAIu9gxCHw/EoqzzKJijXldhdOSyVL22xSbZmlJ2TFoLTSdzULtETdnwXOmj5hGN5Z5W
 epSVtxGumJYFXxEn9KLbtRUh0p7m+hJgmRVq6WB0KNi2AP3lbnXFUopCDme0vuPvEQv8sV
 G1AVe+jcFCFr0OQXEkmnjnJQVsPX59E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-mBYnmW0tMMuaw80pgKsmPw-1; Mon, 27 Jan 2020 07:44:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F9D10054E3;
 Mon, 27 Jan 2020 12:44:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A33F86441;
 Mon, 27 Jan 2020 12:44:24 +0000 (UTC)
Subject: Re: [PATCH] iotests/279: Fix for non-qcow2 formats
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191219144243.1763246-1-mreitz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <09c3452f-d110-1d72-af4a-fd3fd7522ab1@redhat.com>
Date: Mon, 27 Jan 2020 13:44:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219144243.1763246-1-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: mBYnmW0tMMuaw80pgKsmPw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/12/2019 15.42, Max Reitz wrote:
> First, driver=qcow2 will not work so well with non-qcow2 formats (and
> this test claims to support qcow, qed, and vmdk).
> 
> Second, vmdk will always report the backing file format to be vmdk.
> Filter that out so the output looks like for all other formats.
> 
> Third, the flat vmdk subformats do not support backing files, so they
> will not work with this test.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/279 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
> index 6682376808..30d29b1cb2 100755
> --- a/tests/qemu-iotests/279
> +++ b/tests/qemu-iotests/279
> @@ -38,6 +38,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  _supported_fmt qcow qcow2 vmdk qed
>  _supported_proto file
>  _supported_os Linux
> +_unsupported_imgopts "subformat=monolithicFlat" \
> +                     "subformat=twoGbMaxExtentFlat" \
>  
>  TEST_IMG="$TEST_IMG.base" _make_test_img 64M
>  TEST_IMG="$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
> @@ -45,11 +47,12 @@ _make_test_img -b "$TEST_IMG.mid"
>  
>  echo
>  echo '== qemu-img info --backing-chain =='
> -_img_info --backing-chain | _filter_img_info
> +_img_info --backing-chain | _filter_img_info | grep -v 'backing file format'
>  
>  echo
>  echo '== qemu-img info --backing-chain --image-opts =='
> -TEST_IMG="driver=qcow2,file.driver=file,file.filename=$TEST_IMG" _img_info --backing-chain --image-opts | _filter_img_info
> +TEST_IMG="driver=$IMGFMT,file.driver=file,file.filename=$TEST_IMG" _img_info --backing-chain --image-opts \
> +    | _filter_img_info | grep -v 'backing file format'
>  
>  # success, all done
>  echo "*** done"
> 

This fixes the problems with "check -qed 279" and "check -vmdk 279" for me.

Tested-by: Thomas Huth <thuth@redhat.com>


