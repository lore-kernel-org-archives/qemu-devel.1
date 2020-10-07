Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B99C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A765208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 05:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZggF7Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A765208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1Yk-0006Ei-FS
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 01:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1XS-0005Kk-6f
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1XP-0006iq-2Q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602046730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lia97u/DG4JEvThY1wwhQjtAv1D0qBpz04v1+NXMrI0=;
 b=AZggF7RsGzlMz31zOLAPBKb3MBj3fnbx9KFj62a+FxKml/b49stgCFdEWxofk/Pn7XCHS8
 5L2YZN1adpMdWr7ArlEXjJh3etgpFicJrqJhTBmOsOo0IxNc6pGPytqv+tOXu2qCNit13c
 KdNrl1mlJC+IMh7NwRFZiK9K7HS6YFk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-YPMczhv3Nvq0oCZFkpDnvQ-1; Wed, 07 Oct 2020 00:58:48 -0400
X-MC-Unique: YPMczhv3Nvq0oCZFkpDnvQ-1
Received: by mail-wr1-f72.google.com with SMTP id b6so478986wrn.17
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 21:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Lia97u/DG4JEvThY1wwhQjtAv1D0qBpz04v1+NXMrI0=;
 b=RCx/bQ7prefJB1LTnp78dTlTPt0xyl6srq8zoUoJ1dfpU9+HLqZQskvr/JvKU6rSpL
 /tPMGmk3InG6tBSF9Td31C1tso5+ol7swnXpSVT5kVUBBSBJhnkPuqIahyHrOF/7X7Ig
 6a1hladstXXCjfSfb0pPLHoPefasNeWIFnxJPcRWr0N3JFiLOwUE1J6o/E42NYkqreGI
 XS1QiszVEUpGl/uvKuOWZbJQD52LER4PJKtc/COAio87htlSUOIstNPycV3XYeRiBlrJ
 dng+O5By/uuDgxoCaJZYZaGgTQVOLHiXuv2PKG4mthvSUMTDvZo0Lzzm1CD3qcp/p93E
 xmyA==
X-Gm-Message-State: AOAM533t0jO5QKKBGbApBVHAg9kcEcNa1jhtW3a0+wfhoNgZwP+hkEQ/
 f7K1f8F16wJ4rxjycaKoDz+OTjNnIoyWB+/oCwRtXJHljmJ7aSgDF1Hwp83Er2VQyaPiFNQgy8W
 OJq8yl7ph7ft2ovw=
X-Received: by 2002:a05:6000:108a:: with SMTP id
 y10mr1384537wrw.41.1602046726875; 
 Tue, 06 Oct 2020 21:58:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWA6ZnQI0ePQmEz3LP3luHVvnmEtjqmSopnatOnHxt8TQRISPGRBauKumSRXIBoPknNSt2rg==
X-Received: by 2002:a05:6000:108a:: with SMTP id
 y10mr1384520wrw.41.1602046726672; 
 Tue, 06 Oct 2020 21:58:46 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p4sm1103598wru.39.2020.10.06.21.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 21:58:45 -0700 (PDT)
Subject: Re: [PATCH 17/20] python/qemu/qmp.py: Preserve error context on
 re-raise
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-18-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <543e0ac0-1095-33db-b754-2892eb89c927@redhat.com>
Date: Wed, 7 Oct 2020 06:58:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-18-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 1:58 AM, John Snow wrote:
> Use the "from ..." phrasing when re-raising errors to preserve their
> initial context, to help aid debugging when things go wrong.
> 
> This also silences a pylint 2.6.0+ error.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/qmp.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
> index 9223307ed81..d911999da1f 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp.py
> @@ -181,10 +181,11 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
>                  self.__sock.settimeout(wait)
>              try:
>                  ret = self.__json_read(only_event=True)
> -            except socket.timeout:
> -                raise QMPTimeoutError("Timeout waiting for event")
> -            except:
> -                raise QMPConnectError("Error while reading from socket")
> +            except socket.timeout as err:
> +                raise QMPTimeoutError("Timeout waiting for event") from err
> +            except Exception as err:
> +                msg = "Error while reading from socket"
> +                raise QMPConnectError(msg) from err
>              if ret is None:
>                  raise QMPConnectError("Error while reading from socket")
>              self.__sock.settimeout(None)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


