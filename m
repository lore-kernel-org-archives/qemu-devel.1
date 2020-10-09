Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B5EC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1B02222C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEyTpEul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1B02222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpoz-0002Ui-Pu
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQpgP-0000dV-Cu
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQpgJ-0003K8-41
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602239481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lB121yWMqTInHo78ldIqAs4CNDWnsg9keM4f7iV627s=;
 b=aEyTpEulAh0wm8DbODOJ1RO3sel+op2IKCIW4XXrdZfqNYenZF5D5GdZGScEI0SnzPHtpV
 gqAGfkw7cLEbMd0GlcW8imEFu55/DwAojW7WtzMXFHTq2qvGoNRi4kk8MNoaZ1Z1r+gzTu
 NlHVG92HclRkxrGTJwZjO/Mo0JDl8Fc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-JNPui4JyNd-xTi9CVCQqrQ-1; Fri, 09 Oct 2020 06:31:19 -0400
X-MC-Unique: JNPui4JyNd-xTi9CVCQqrQ-1
Received: by mail-wr1-f70.google.com with SMTP id l20so5059059wrc.20
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 03:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lB121yWMqTInHo78ldIqAs4CNDWnsg9keM4f7iV627s=;
 b=f55s6njvZ8qTwVLI+BGZ/3IQvyMIzAunG4f6eiN53eYhZ+daRpEBAf+GDF1lkKb500
 0B5MhZYXgfxekC26f1Zd2lspjBNaa/kzfsgfUareZfvSBynzCUv72gsk7NmaOCQmh5kV
 gNjaigrYvMS5wwfs6724i2Li/N5UFpMKaQXEMNaO1kDXjRrwDMuzbm/2x2wB/uLE3m1q
 G+g/3++aG1nCy1zwUl7Q4TK09DtNFCWh2ZLx56s8hNEE7DT16oCyqL274+aBFm7Sd1AM
 ja69OPtUzLIml8c4ZSQO+E+LbkEyPOspQ7t9mMCgvwRRUujnednG5XYhxomv9tqOQVKP
 bD+g==
X-Gm-Message-State: AOAM5327mbBxg77McNqOLzVxd0+bp6Uru/60vdCqNEV7fdzPsptqSlS0
 9Jx4uBoUSaNxMY4KyeYmkc0cGyXIgqNbtgDAsMWbfbqxc26wAOC/gJ1ASh1UFEaSoIEy0IDgPks
 SZKCT503WqZBvujg=
X-Received: by 2002:a1c:23c2:: with SMTP id
 j185mr12820944wmj.136.1602239478549; 
 Fri, 09 Oct 2020 03:31:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGXQQ/sNtQlKbtTcSDTJGMYnTn4ecp92lfI68+lAZPJj1KNIsSH7QiVbQcsS9EWuB5PycPxg==
X-Received: by 2002:a1c:23c2:: with SMTP id
 j185mr12820915wmj.136.1602239478328; 
 Fri, 09 Oct 2020 03:31:18 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d18sm11284393wrm.10.2020.10.09.03.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 03:31:17 -0700 (PDT)
Subject: Re: [PATCH 1/3] authz-list-file: Fix crash when filename is not set
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201008202713.1416823-1-ehabkost@redhat.com>
 <20201008202713.1416823-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <378eb905-411a-96a5-456f-54032531b26d@redhat.com>
Date: Fri, 9 Oct 2020 12:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008202713.1416823-2-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 10:27 PM, Eduardo Habkost wrote:
> Fix the following crash:
> 
>    $ qemu-system-x86_64 -object authz-list-file,id=obj0
>    qemu-system-x86_64: -object authz-list-file,id=obj0: GLib: g_file_get_contents: assertion 'filename != NULL' failed
>    Segmentation fault (core dumped)
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>   authz/listfile.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/authz/listfile.c b/authz/listfile.c
> index cd6163aa40..aaf930453d 100644
> --- a/authz/listfile.c
> +++ b/authz/listfile.c
> @@ -122,6 +122,11 @@ qauthz_list_file_complete(UserCreatable *uc, Error **errp)
>       QAuthZListFile *fauthz = QAUTHZ_LIST_FILE(uc);
>       gchar *dir = NULL, *file = NULL;
>   
> +    if (!fauthz->filename) {
> +        error_setg(errp, "filename not provided");
> +        return;
> +    }
> +
>       fauthz->list = qauthz_list_file_load(fauthz, errp);
>   
>       if (!fauthz->refresh) {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


