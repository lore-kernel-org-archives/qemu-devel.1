Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AEBCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 18:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AA820856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 18:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ur2hkmJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AA820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPsx6-00052m-Vv
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 14:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iPsv9-0002ol-Dr
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iPsv6-00070Z-Im
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:42:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iPsv5-0006ya-VB
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 14:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572460929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eOsO/UJAPB6WENOx1Bv6tDiipjFT6VXWNeQ9oqLKsI=;
 b=Ur2hkmJcHFTnDyLvA3Lk1koh+0tnORbcsTH1U7v4hs6hvuhzrv7GnGmeXF526+SsDH6zqb
 l6fdIw/4vmXf9rO5hqw4bYbEwSzmAqbadZAOcIvfc5xnSQ2BeZ8VVOy+DvWg/Nw/aYvUMA
 qtiEKjSuTmhBm0+AY8P+TJuxWs6/Njk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-QzByF1NFPMeH_3O5zV5Gnw-1; Wed, 30 Oct 2019 14:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B037107ACC0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 18:42:03 +0000 (UTC)
Received: from work-vm (ovpn-116-18.ams2.redhat.com [10.36.116.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E200510016DA;
 Wed, 30 Oct 2019 18:41:56 +0000 (UTC)
Date: Wed, 30 Oct 2019 18:41:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] tests/fw_cfg: Test 'reboot-timeout=-1' special value
Message-ID: <20191030184153.GB3114@work-vm>
References: <20191029170124.27981-1-philmd@redhat.com>
 <20191029170124.27981-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191029170124.27981-3-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QzByF1NFPMeH_3O5zV5Gnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> The special value -1 means "don't reboot" for QEMU/libvirt.
> Add a trivial test.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  tests/fw_cfg-test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1d3147f821..5dc807ba23 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -194,6 +194,26 @@ static void test_fw_cfg_reboot_timeout(void)
>      qtest_quit(s);
>  }
> =20
> +static void test_fw_cfg_no_reboot_timeout(void)
> +{
> +    QFWCFG *fw_cfg;
> +    QTestState *s;
> +    uint32_t reboot_timeout =3D 0;
> +    size_t filesize;
> +
> +    /* Special value -1 means "don't reboot" */
> +    s =3D qtest_init("-boot reboot-timeout=3D-1");
> +    fw_cfg =3D pc_fw_cfg_init(s);
> +
> +    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +                                &reboot_timeout, sizeof(reboot_timeout))=
;
> +    g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
> +    reboot_timeout =3D le32_to_cpu(reboot_timeout);
> +    g_assert_cmpint(reboot_timeout, =3D=3D, UINT32_MAX);
> +    pc_fw_cfg_uninit(fw_cfg);
> +    qtest_quit(s);
> +}
> +
>  static void test_fw_cfg_splash_time(void)
>  {
>      QFWCFG *fw_cfg;
> @@ -233,6 +253,7 @@ int main(int argc, char **argv)
>      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
>      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
>      qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
> +    qtest_add_func("fw_cfg/no_reboot_timeout", test_fw_cfg_no_reboot_tim=
eout);
>      qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
> =20
>      return g_test_run();
> --=20
> 2.21.0
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


