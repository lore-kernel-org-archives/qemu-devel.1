Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546EEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A433D206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCb50Jz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A433D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIE2E-0006WS-Jf
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIE1F-0005nc-QH
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:41:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIE1D-0007RV-C0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600188082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aRVFwpIIX+feLpOndU3aAC4Yw1VDqv29SgSDhywjXuY=;
 b=hCb50Jz4i2qTS20WW+jTu6Odc8GEcqOet7g1plVUA0Z3K3NavwaejFr+VQK9krwxd2fl1Z
 bjbW47bDkClXU8oFdMUhE0dHn9AoIlXObmUKFF6MUHqfuZpg3tvVsXR+y6wy7XS4VWEsSJ
 5JnVZhodXz60Jags+5EL+NXL/Xs4OLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-FRItQSyiP4G_lNsHZZeUzQ-1; Tue, 15 Sep 2020 12:41:20 -0400
X-MC-Unique: FRItQSyiP4G_lNsHZZeUzQ-1
Received: by mail-wr1-f69.google.com with SMTP id x15so1431399wrm.7
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=POvtAE37SnADrvNNjqhqmmHLdfOtHXlnUEDPfCXo8yk=;
 b=PGQBkeMP/By3UcLB2nhqNO2h9qk3ScXYEqffxQ9ZKeSWQPTSMaIsfgLd6dVsblJbRm
 TSBV3APpPBw4knOme+lB465ePlBr6qo7hLbHJofiDiReJv5lKXfpaHeLtn7ih/m8lIDX
 U8mHnu3VLL80N/sjqDXC5/+NX8mz+QIP3aP+W9TZ/BSZn7U6UXEs4/vjniIyap/JG+H+
 PBUbEUNPEotnZM0Wd5mdb6jEQPTe+WGmWk/Z2myEoIckpzcAz4vbPE4rAdpA/lI2M1NA
 Pw6sgje7ZxMLrPGgTIGHr59mkHe2Eau4ADwGomtskddfJwvg9wuZ/zstfWpIeJKKAIzN
 lSoQ==
X-Gm-Message-State: AOAM532q6IbgzFQV2ITcW46slwIAl67i7+3cT92dF7iW+ExlBtH4E75N
 hAWs+Qh1ojCQiID0VCURJLgA/Rwbx68AMRDBNTmn8+etai7AEriqhpSGAhqA29CsLVCV1tdpY4A
 UgYtMHgge+G5AEKg=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr22249930wrs.227.1600188079231; 
 Tue, 15 Sep 2020 09:41:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhJNR0vcDmq4j9IeZkabzwOK8qrJ91msQv0W2K9cbJUdK23vKg/OVMN/maHgSHAQduaFcuKQ==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr22249907wrs.227.1600188078978; 
 Tue, 15 Sep 2020 09:41:18 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v17sm27611733wrr.60.2020.09.15.09.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 09:41:18 -0700 (PDT)
Subject: Re: [PATCH] guest agent: Fixes for windows guest agent building on
 msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200915163343.1100-1-luoyonggang@gmail.com>
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
Message-ID: <06c76888-b2c1-866f-f6f5-78ee9a2bac0c@redhat.com>
Date: Tue, 15 Sep 2020 18:41:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915163343.1100-1-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 11:09:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gOS8xNS8yMCA2OjMzIFBNLCBZb25nZ2FuZyBMdW8gd3JvdGU6DQo+IGVycm9yIG1lc3NhZ2U6
DQo+ICJjYyIgIi1JcWdhL3FlbXUtZ2EuZXhlLnAiICItSXFnYSIgIi1JLi4vcWdhIiAiLUkuIiAi
LUlxYXBpIiAiLUl0cmFjZSIgIi1JdWkiICItSXVpL3NoYWRlciIgIi1JQzovQ0ktVG9vbHMvbXN5
czY0L21pbmd3NjQvaW5jbHVkZSIgIi1JQzovQ0ktVG9vbHMvbXN5czY0L21pbmd3NjQvaW5jbHVk
ZS9nbGliLTIuMCIgIi1JQzovQ0ktVG9vbHMvbXN5czY0L21pbmd3NjQvbGliL2dsaWItMi4wL2lu
Y2x1ZGUiICItZmRpYWdub3N0aWNzLWNvbG9yPWF1dG8iICItcGlwZSIgIi1XYWxsIiAiLVdpbnZh
bGlkLXBjaCIgIi1XZXJyb3IiICItc3RkPWdudTk5IiAiLWciICItbTY0IiAiLW1jeDE2IiAiLURf
R05VX1NPVVJDRSIgIi1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQiICItRF9MQVJHRUZJTEVfU09VUkNF
IiAiLVdzdHJpY3QtcHJvdG90eXBlcyIgIi1XcmVkdW5kYW50LWRlY2xzIiAiLVd1bmRlZiIgIi1X
d3JpdGUtc3RyaW5ncyIgIi1XbWlzc2luZy1wcm90b3R5cGVzIiAiLWZuby1zdHJpY3QtYWxpYXNp
bmciICItZm5vLWNvbW1vbiIgIi1md3JhcHYiICItV29sZC1zdHlsZS1kZWNsYXJhdGlvbiIgIi1X
b2xkLXN0eWxlLWRlZmluaXRpb24iICItV3R5cGUtbGltaXRzIiAiLVdmb3JtYXQtc2VjdXJpdHki
ICItV2Zvcm1hdC15MmsiICItV2luaXQtc2VsZiIgIi1XaWdub3JlZC1xdWFsaWZpZXJzIiAiLVdl
bXB0eS1ib2R5IiAiLVduZXN0ZWQtZXh0ZXJucyIgIi1XZW5kaWYtbGFiZWxzIiAiLVdleHBhbnNp
b24tdG8tZGVmaW5lZCIgIi1Xbm8tbWlzc2luZy1pbmNsdWRlLWRpcnMiICItV25vLXNoaWZ0LW5l
Z2F0aXZlLXZhbHVlIiAiLVduby1wc2FiaSIgIi1mc3RhY2stcHJvdGVjdG9yLXN0cm9uZyIgIi1p
cXVvdGUiICIvYy93b3JrL3hlbXUvcWVtdS90Y2cvaTM4NiIgIi1pcXVvdGUiICIuIiAiLWlxdW90
ZSIgIi9jL3dvcmsveGVtdS9xZW11IiAiLWlxdW90ZSIgIi9jL3dvcmsveGVtdS9xZW11L2FjY2Vs
L3RjZyIgIi1pcXVvdGUiICIvYy93b3JrL3hlbXUvcWVtdS9pbmNsdWRlIiAiLWlxdW90ZSIgIi9j
L3dvcmsveGVtdS9xZW11L2Rpc2FzL2xpYnZpeGwiICItcHRocmVhZCIgIi1tbXMtYml0ZmllbGRz
IiAtTUQgLU1RIHFnYS9xZW11LWdhLmV4ZS5wL2NvbW1hbmRzLXdpbjMyLmMub2JqIC1NRiAicWdh
L3FlbXUtZ2EuZXhlLnAvY29tbWFuZHMtd2luMzIuYy5vYmouZCIgLW8gcWdhL3FlbXUtZ2EuZXhl
LnAvY29tbWFuZHMtd2luMzIuYy5vYmogIi1jIiAuLi9xZ2EvY29tbWFuZHMtd2luMzIuYyAtTVAN
Cj4gLi4vcWdhL2NvbW1hbmRzLXdpbjMyLmM6NjI6MjQ6IGVycm9yOiByZWR1bmRhbnQgcmVkZWNs
YXJhdGlvbiBvZiAnQ01fR2V0X0Rldk5vZGVfUHJvcGVydHlXJyBbLVdlcnJvcj1yZWR1bmRhbnQt
ZGVjbHNdDQo+ICAgIDYyIHwgQ01BUEkgQ09ORklHUkVUIFdJTkFQSSBDTV9HZXRfRGV2Tm9kZV9Q
cm9wZXJ0eVcoDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4NCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uL3FnYS9jb21tYW5kcy13aW4z
Mi5jOjI2Og0KPiBDOi9DSS1Ub29scy9tc3lzNjQvbWluZ3c2NC94ODZfNjQtdzY0LW1pbmd3MzIv
aW5jbHVkZS9jZmdtZ3IzMi5oOjg0MDoyNjogbm90ZTogcHJldmlvdXMgZGVjbGFyYXRpb24gb2Yg
J0NNX0dldF9EZXZOb2RlX1Byb3BlcnR5Vycgd2FzIGhlcmUNCj4gICA4NDAgfCAgIENNQVBJIENP
TkZJR1JFVCBXSU5BUEkgQ01fR2V0X0Rldk5vZGVfUHJvcGVydHlXKERFVklOU1QgZG5EZXZJbnN0
LCBjb25zdCBERVZQUk9QS0VZICpQcm9wZXJ0eUtleSwgREVWUFJPUFRZUEUgKlByb3BlcnR5VHlw
ZSwgUEJZVEUgUHJvcGVydHlCdWZmZXIsIFBVTE9ORyBQcm9wZXJ0eUJ1ZmZlclNpemUsIFVMT05H
IHVsRmxhZ3MpOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4gY2MxLmV4ZTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzDQo+IG1ha2U6IFtNYWtlZmlsZS5uaW5qYTo1MTQz77yacWdhL3FlbXUtZ2EuZXhlLnAv
Y29tbWFuZHMtd2luMzIuYy5vYmpdIOmUmeivryAxICjlt7Llv73nlaXvvIkNCj4gDQo+IFRoaXMg
ZXJyb3IgY29tZXMgZnJvbSBxZW11IGNvbmZpZ3VyZSBkaWRuJ3QgYWRkIHByZWRlZmluZWQgbWFj
cm8gLURVTklDT0RFIC1EX1VOSUNPREUgaW4gUUVNVV9DRkxBR1MsDQo+IGFuZCB0aGVzZSB0b28g
bWFjcm8gYXJlIHN0YW5kYXJkIGNvbmZpZyBmb3Igd2luMzIgaWYgdXNpbmcgd2luZG93cyB3aWRl
IGFwaS4NCj4gDQo+IGluIGNmZ21ncjMyLmgNCj4gICBDTUFQSSBDT05GSUdSRVQgV0lOQVBJIENN
X0dldF9EZXZOb2RlX1Byb3BlcnR5VyhERVZJTlNUIGRuRGV2SW5zdCwgY29uc3QgREVWUFJPUEtF
WSAqUHJvcGVydHlLZXksIERFVlBST1BUWVBFICpQcm9wZXJ0eVR5cGUsIFBCWVRFIFByb3BlcnR5
QnVmZmVyLCBQVUxPTkcgUHJvcGVydHlCdWZmZXJTaXplLCBVTE9ORyB1bEZsYWdzKTsNCj4gI2lm
ZGVmIFVOSUNPREUNCj4gI2RlZmluZSBDTV9HZXRfRGV2Tm9kZV9Qcm9wZXJ0eSBDTV9HZXRfRGV2
Tm9kZV9Qcm9wZXJ0eVcNCj4gI2VuZGlmDQo+IA0KPiBtYWNybyBDTV9HZXRfRGV2Tm9kZV9Qcm9w
ZXJ0eSBkZWZpbmVkIG9ubHkgd2hlbiBVTklDT0RFIGFyZSBkZWZpbmVkLg0KPiBhbmQgaW4gd2lu
MzIsIFVOSUNPREUgYW5kIF9VTklDT0RFIHNob3VsZCBiZSBkZWZpbmVkIGF0IHRoZSBzYW1lIHRp
bWUNCj4gDQo+ICNlbmRpZg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWW9uZ2dhbmcgTHVvIDxsdW95
b25nZ2FuZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgY29uZmlndXJlIHwgMSArDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9j
b25maWd1cmUNCj4gaW5kZXggOWYxNDE4OTFlYS4uZjVkNjYxYWY0YSAxMDA3NTUNCj4gLS0tIGEv
Y29uZmlndXJlDQo+ICsrKyBiL2NvbmZpZ3VyZQ0KPiBAQCAtODEyLDYgKzgxMiw3IEBAIE1JTkdX
MzIqKQ0KPiAgICBtaW5ndzMyPSJ5ZXMiDQo+ICAgIGhheD0ieWVzIg0KPiAgICB3aHB4PSIiDQo+
ICsgIFFFTVVfQ0ZMQUdTPSItRFVOSUNPREUgLURfVU5JQ09ERSAkUUVNVV9DRkxBR1MiDQoNCldo
YXQgYWJvdXQgZGVjbGFyaW5nIHRoZW0gaW4gaW5jbHVkZS9xZW11L29zZGVwLmgNCmluc3RlYWQ/
DQoNCi0tID44IC0tDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L29zZGVwLmggYi9pbmNsdWRl
L3FlbXUvb3NkZXAuaA0KaW5kZXggNDEyOTYyZDkxYTIuLmNkNWNlZGMwYjIxIDEwMDY0NA0KLS0t
IGEvaW5jbHVkZS9xZW11L29zZGVwLmgNCisrKyBiL2luY2x1ZGUvcWVtdS9vc2RlcC5oDQpAQCAt
NzQsNiArNzQsMTIgQEAgZXh0ZXJuIGludCBkYWVtb24oaW50LCBpbnQpOw0KIC8qIGVuYWJsZSBD
OTkvUE9TSVggZm9ybWF0IHN0cmluZ3MgKG5lZWRzIG1pbmd3MzItcnVudGltZSAzLjE1IG9yIGxh
dGVyKSAqLw0KICNpZmRlZiBfX01JTkdXMzJfXw0KICNkZWZpbmUgX19VU0VfTUlOR1dfQU5TSV9T
VERJTyAxDQorI2lmbmRlZiBVTklDT0RFDQorI2RlZmluZSBVTklDT0RFDQorI2VuZGlmDQorI2lm
bmRlZiBfVU5JQ09ERQ0KKyNkZWZpbmUgX1VOSUNPREUNCisjZW5kaWYNCiAjZW5kaWYNCg0KICNp
bmNsdWRlIDxzdGRhcmcuaD4NCi0tLQ0KDQo+ICAgIHZob3N0X3VzZXI9Im5vIg0KPiAgICBhdWRp
b19wb3NzaWJsZV9kcml2ZXJzPSJkc291bmQgc2RsIg0KPiAgICBpZiBjaGVja19pbmNsdWRlIGRz
b3VuZC5oOyB0aGVuDQo+IA0KDQo=


