Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79589C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36338206DC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 03:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="ltt/+arq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36338206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibyxW-0002yJ-DL
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 22:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1ibywU-0001ut-EE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1ibywS-0004O0-M7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:33:38 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ibywS-0004Me-CZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 22:33:36 -0500
Received: by mail-pg1-x542.google.com with SMTP id k1so969937pgg.12
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 19:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=05FQmTyDuPh8I5luJcJcG2WZRkFP5/Nddbpdz4wRCDo=;
 b=ltt/+arqHLmiLDC8e+TsypDgJH/5j+963vhHkvwjwo9T0djYraxoL0Uwq8w684tARf
 8unnwQENz26gbmUO3DwriQP3XjWd3B2i/WeF4+7kkdNla09fK6ozl7LvH8vfsbTUM87W
 PpFR/E2rHXGoSZeCKL9FRFCx3FWza55qOVIgigZgjb4jQG0yrR3PjeCqhm6oTMDROY3o
 ce+dP3AXe1Gz+vw/hiD8HbGmSP3LGQo328OsRyMaxG7merYTNEXsk3T0f7UUwt48UOMm
 tw53z7e1E/APJOvQGDb6KnbM5AYJYH6EhhT6ikYCKC0/tOu6O3a5csKiN9+7CIG/UqpB
 /W/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=05FQmTyDuPh8I5luJcJcG2WZRkFP5/Nddbpdz4wRCDo=;
 b=X30z0Hvs3htCU6CxQOXtq4xXzuqqKu92GQ6Mc+RiTvZnrpy4fa/mUBYeEPkYTbk9Qq
 qGCUjrsrKupfzBu/B1U76nzZg1trWQst+/m7i7/8A/OMmwBK5DPC82+3QYiF4WXysE3/
 0wntC3nxFCkyqT1vK0XHieeUPDns3rFqpNWLg27qBv2SEcw+I6HcyubUbe7Ke340hkEB
 4BUe0Xdp5ZiTegrnUjkqnsRsfnOAmk79qsst6IBXIt695UAec5q2v78053GuUnpvILF+
 Q26WMer+f5nSAyMK0p1sSo7MyEjr3zmc/OXhCdXDkWd/yM501yzbwZcGlCh/2RsivUaw
 /hGg==
X-Gm-Message-State: APjAAAXu0rbl+lryCNLwW51c6VhnOBgVOLKg3zPtS/9O0EFfUlxLZJ3S
 U9na1cwENM4asIEYfPKVJJkX2jsEiSA=
X-Google-Smtp-Source: APXvYqws+aq+Dr4Hq//BDy4hwMvCdkUwah73zwJLTAtZkacgKTrJp2VKubBmMVzVbEPn3ahuJVEFiA==
X-Received: by 2002:a05:6a00:9c:: with SMTP id
 c28mr2568658pfj.234.1575344015172; 
 Mon, 02 Dec 2019 19:33:35 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id q3sm1051601pfc.114.2019.12.02.19.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 19:33:34 -0800 (PST)
Subject: Re: [for-5.0 2/4] spapr: Don't attempt to clamp RMA to VRMA constraint
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, clg@kaod.org
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
 <20191129013504.145455-3-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 mQINBE+rT0sBEADFEI2UtPRsLLvnRf+tI9nA8T91+jDK3NLkqV+2DKHkTGPP5qzDZpRSH6mD
 EePO1JqpVuIow/wGud9xaPA5uvuVgRS1q7RU8otD+7VLDFzPRiRE4Jfr2CW89Ox6BF+q5ZPV
 /pS4v4G9eOrw1v09lEKHB9WtiBVhhxKK1LnUjPEH3ifkOkgW7jFfoYgTdtB3XaXVgYnNPDFo
 PTBYsJy+wr89XfyHr2Ev7BB3Xaf7qICXdBF8MEVY8t/UFsesg4wFWOuzCfqxFmKEaPDZlTuR
 tfLAeVpslNfWCi5ybPlowLx6KJqOsI9R2a9o4qRXWGP7IwiMRAC3iiPyk9cknt8ee6EUIxI6
 t847eFaVKI/6WcxhszI0R6Cj+N4y+1rHfkGWYWupCiHwj9DjILW9iEAncVgQmkNPpUsZECLT
 WQzMuVSxjuXW4nJ6f4OFHqL2dU//qR+BM/eJ0TT3OnfLcPqfucGxubhT7n/CXUxEy+mvWwnm
 s9p4uqVpTfEuzQ0/bE6t7dZdPBua7eYox1AQnk8JQDwC3Rn9kZq2O7u5KuJP5MfludMmQevm
 pHYEMF4vZuIpWcOrrSctJfIIEyhDoDmR34bCXAZfNJ4p4H6TPqPh671uMQV82CfTxTrMhGFq
 8WYU2AH86FrVQfWoH09z1WqhlOm/KZhAV5FndwVjQJs1MRXD8QARAQABtCRBbGV4ZXkgS2Fy
 ZGFzaGV2c2tpeSA8YWlrQG96bGFicy5ydT6JAjgEEwECACIFAk+rT0sCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJEIYTPdgrwSC5fAIP/0wf/oSYaCq9PhO0UP9zLSEz66SSZUf7
 AM9O1rau1lJpT8RoNa0hXFXIVbqPPKPZgorQV8SVmYRLr0oSmPnTiZC82x2dJGOR8x4E01gK
 TanY53J/Z6+CpYykqcIpOlGsytUTBA+AFOpdaFxnJ9a8p2wA586fhCZHVpV7W6EtUPH1SFTQ
 q5xvBmr3KkWGjz1FSLH4FeB70zP6uyuf/B2KPmdlPkyuoafl2UrU8LBADi/efc53PZUAREih
 sm3ch4AxaL4QIWOmlE93S+9nHZSRo9jgGXB1LzAiMRII3/2Leg7O4hBHZ9Nki8/fbDo5///+
 kD4L7UNbSUM/ACWHhd4m1zkzTbyRzvL8NAVQ3rckLOmju7Eu9whiPueGMi5sihy9VQKHmEOx
 OMEhxLRQbzj4ypRLS9a+oxk1BMMu9cd/TccNy0uwx2UUjDQw/cXw2rRWTRCxoKmUsQ+eNWEd
 iYLW6TCfl9CfHlT6A7Zmeqx2DCeFafqEd69DqR9A8W5rx6LQcl0iOlkNqJxxbbW3ddDsLU/Y
 r4cY20++WwOhSNghhtrroP+gouTOIrNE/tvG16jHs8nrYBZuc02nfX1/gd8eguNfVX/ZTHiR
 gHBWe40xBKwBEK2UeqSpeVTohYWGBkcd64naGtK9qHdo1zY1P55lHEc5Uhlk743PgAnOi27Q
 ns5zuQINBE+rT0sBEACnV6GBSm+25ACT+XAE0t6HHAwDy+UKfPNaQBNTTt31GIk5aXb2Kl/p
 AgwZhQFEjZwDbl9D/f2GtmUHWKcCmWsYd5M/6Ljnbp0Ti5/xi6FyfqnO+G/wD2VhGcKBId1X
 Em/B5y1kZVbzcGVjgD3HiRTqE63UPld45bgK2XVbi2+x8lFvzuFq56E3ZsJZ+WrXpArQXib2
 hzNFwQleq/KLBDOqTT7H+NpjPFR09Qzfa7wIU6pMNF2uFg5ihb+KatxgRDHg70+BzQfa6PPA
 o1xioKXW1eHeRGMmULM0Eweuvpc7/STD3K7EJ5bBq8svoXKuRxoWRkAp9Ll65KTUXgfS+c0x
 gkzJAn8aTG0z/oEJCKPJ08CtYQ5j7AgWJBIqG+PpYrEkhjzSn+DZ5Yl8r+JnZ2cJlYsUHAB9
 jwBnWmLCR3gfop65q84zLXRQKWkASRhBp4JK3IS2Zz7Nd/Sqsowwh8x+3/IUxVEIMaVoUaxk
 Wt8kx40h3VrnLTFRQwQChm/TBtXqVFIuv7/Mhvvcq11xnzKjm2FCnTvCh6T2wJw3de6kYjCO
 7wsaQ2y3i1Gkad45S0hzag/AuhQJbieowKecuI7WSeV8AOFVHmgfhKti8t4Ff758Z0tw5Fpc
 BFDngh6Lty9yR/fKrbkkp6ux1gJ2QncwK1v5kFks82Cgj+DSXK6GUQARAQABiQIfBBgBAgAJ
 BQJPq09LAhsMAAoJEIYTPdgrwSC5NYEP/2DmcEa7K9A+BT2+G5GXaaiFa098DeDrnjmRvumJ
 BhA1UdZRdfqICBADmKHlJjj2xYo387sZpS6ABbhrFxM6s37g/pGPvFUFn49C47SqkoGcbeDz
 Ha7JHyYUC+Tz1dpB8EQDh5xHMXj7t59mRDgsZ2uVBKtXj2ZkbizSHlyoeCfs1gZKQgQE8Ffc
 F8eWKoqAQtn3j4nE3RXbxzTJJfExjFB53vy2wV48fUBdyoXKwE85fiPglQ8bU++0XdOr9oyy
 j1llZlB9t3tKVv401JAdX8EN0++ETiOovQdzE1m+6ioDCtKEx84ObZJM0yGSEGEanrWjiwsa
 nzeK0pJQM9EwoEYi8TBGhHC9ksaAAQipSH7F2OHSYIlYtd91QoiemgclZcSgrxKSJhyFhmLr
 QEiEILTKn/pqJfhHU/7R7UtlDAmFMUp7ByywB4JLcyD10lTmrEJ0iyRRTVfDrfVP82aMBXgF
 tKQaCxcmLCaEtrSrYGzd1sSPwJne9ssfq0SE/LM1J7VdCjm6OWV33SwKrfd6rOtvOzgadrG6
 3bgUVBw+bsXhWDd8tvuCXmdY4bnUblxF2B6GOwSY43v6suugBttIyW5Bl2tXSTwP+zQisOJo
 +dpVG2pRr39h+buHB3NY83NEPXm1kUOhduJUA17XUY6QQCAaN4sdwPqHq938S3EmtVhsuQIN
 BFq54uIBEACtPWrRdrvqfwQF+KMieDAMGdWKGSYSfoEGGJ+iNR8v255IyCMkty+yaHafvzpl
 PFtBQ/D7Fjv+PoHdFq1BnNTk8u2ngfbre9wd9MvTDsyP/TmpF0wyyTXhhtYvE267Av4X/BQT
 lT9IXKyAf1fP4BGYdTNgQZmAjrRsVUW0j6gFDrN0rq2J9emkGIPvt9rQt6xGzrd6aXonbg5V
 j6Uac1F42ESOZkIh5cN6cgnGdqAQb8CgLK92Yc8eiCVCH3cGowtzQ2m6U32qf30cBWmzfSH0
 HeYmTP9+5L8qSTA9s3z0228vlaY0cFGcXjdodBeVbhqQYseMF9FXiEyRs28uHAJEyvVZwI49
 CnAgVV/n1eZa5qOBpBL+ZSURm8Ii0vgfvGSijPGbvc32UAeAmBWISm7QOmc6sWa1tobCiVmY
 SNzj5MCNk8z4cddoKIc7Wt197+X/X5JPUF5nQRvg3SEHvfjkS4uEst9GwQBpsbQYH9MYWq2P
 PdxZ+xQE6v7cNB/pGGyXqKjYCm6v70JOzJFmheuUq0Ljnfhfs15DmZaLCGSMC0Amr+rtefpA
 y9FO5KaARgdhVjP2svc1F9KmTUGinSfuFm3quadGcQbJw+lJNYIfM7PMS9fftq6vCUBoGu3L
 j4xlgA/uQl/LPneu9mcvit8JqcWGS3fO+YeagUOon1TRqQARAQABiQRsBBgBCAAgFiEEZSrP
 ibrORRTHQ99dhhM92CvBILkFAlq54uICGwICQAkQhhM92CvBILnBdCAEGQEIAB0WIQQIhvWx
 rCU+BGX+nH3N7sq0YorTbQUCWrni4gAKCRDN7sq0YorTbVVSD/9V1xkVFyUCZfWlRuryBRZm
 S4GVaNtiV2nfUfcThQBfF0sSW/aFkLP6y+35wlOGJE65Riw1C2Ca9WQYk0xKvcZrmuYkK3DZ
 0M9/Ikkj5/2v0vxz5Z5w/9+IaCrnk7pTnHZuZqOh23NeVZGBls/IDIvvLEjpD5UYicH0wxv+
 X6cl1RoP2Kiyvenf0cS73O22qSEw0Qb9SId8wh0+ClWet2E7hkjWFkQfgJ3hujR/JtwDT/8h
 3oCZFR0KuMPHRDsCepaqb/k7VSGTLBjVDOmr6/C9FHSjq0WrVB9LGOkdnr/xcISDZcMIpbRm
 EkIQ91LkT/HYIImL33ynPB0SmA+1TyMgOMZ4bakFCEn1vxB8Ir8qx5O0lHMOiWMJAp/PAZB2
 r4XSSHNlXUaWUg1w3SG2CQKMFX7vzA31ZeEiWO8tj/c2ZjQmYjTLlfDK04WpOy1vTeP45LG2
 wwtMA1pKvQ9UdbYbovz92oyZXHq81+k5Fj/YA1y2PI4MdHO4QobzgREoPGDkn6QlbJUBf4To
 pEbIGgW5LRPLuFlOPWHmIS/sdXDrllPc29aX2P7zdD/ivHABslHmt7vN3QY+hG0xgsCO1JG5
 pLORF2N5XpM95zxkZqvYfC5tS/qhKyMcn1kC0fcRySVVeR3tUkU8/caCqxOqeMe2B6yTiU1P
 aNDq25qYFLeYxg67D/4w/P6BvNxNxk8hx6oQ10TOlnmeWp1q0cuutccblU3ryRFLDJSngTEu
 ZgnOt5dUFuOZxmMkqXGPHP1iOb+YDznHmC0FYZFG2KAc9pO0WuO7uT70lL6larTQrEneTDxQ
 CMQLP3qAJ/2aBH6SzHIQ7sfbsxy/63jAiHiT3cOaxAKsWkoV2HQpnmPOJ9u02TPjYmdpeIfa
 X2tXyeBixa3i/6dWJ4nIp3vGQicQkut1YBwR7dJq67/FCV3Mlj94jI0myHT5PIrCS2S8LtWX
 ikTJSxWUKmh7OP5mrqhwNe0ezgGiWxxvyNwThOHc5JvpzJLd32VDFilbxgu4Hhnf6LcgZJ2c
 Zd44XWqUu7FzVOYaSgIvTP0hNrBYm/E6M7yrLbs3JY74fGzPWGRbBUHTZXQEqQnZglXaVB5V
 ZhSFtHopZnBSCUSNDbB+QGy4B/E++Bb02IBTGl/JxmOwG+kZUnymsPvTtnNIeTLHxN/H/ae0
 c7E5M+/NpslPCmYnDjs5qg0/3ihh6XuOGggZQOqrYPC3PnsNs3NxirwOkVPQgO6mXxpuifvJ
 DG9EMkK8IBXnLulqVk54kf7fE0jT/d8RTtJIA92GzsgdK2rpT1MBKKVffjRFGwN7nQVOzi4T
 XrB5p+6ML7Bd84xOEGsj/vdaXmz1esuH7BOZAGEZfLRCHJ0GVCSssg==
Message-ID: <d2784a5f-5410-5eee-14f8-d9157946b8b0@ozlabs.ru>
Date: Tue, 3 Dec 2019 14:33:30 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129013504.145455-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29/11/2019 12:35, David Gibson wrote:
> The Real Mode Area (RMA) is the part of memory which a guest can access
> when in real (MMU off) mode.  Of course, for a guest under KVM, the MMU
> isn't really turned off, it's just in a special translation mode - Virtual
> Real Mode Area (VRMA) - which looks like real mode in guest mode.
> 
> The mechanics of how this works when in Hashed Page Table (HPT) mode, put
> a constraint on the size of the RMA, which depends on the size of the HPT.
> So, the latter part of spapr_setup_hpt_and_vrma() clamps the RMA we
> advertise to the guest based on this VRMA limit.
> 
> There are several things wrong with this:
>  1) spapr_setup_hpt_and_vrma() doesn't actually clamp, it takes the minimum
>     of Node 0 memory size and the VRMA limit.  That will *often* work the
>     same as clamping, but there can be other constraints on RMA size which
>     supersede Node 0 memory size.  We have real bugs caused by this
>     (currently worked around in the guest kernel)
>  2) Some callers of spapr_setup_hpt_and_vrma() are in a situation where
>     we're past the point that we can actually advertise an RMA limit to the
>     guest
>  3) But most fundamentally, the VRMA limit depends on host configuration
>     (page size) which shouldn't be visible to the guest, but this partially
>     exposes it.  This can cause problems with migration in certain edge
>     cases, although we will mostly get away with it.
> 
> In practice, this clamping is almost never applied anyway.  With 64kiB
> pages and the normal rules for sizing of the HPT, the theoretical VRMA
> limit will be 4x(guest memory size) and so never hit.  It will hit with
> 4kiB pages, where it will be (guest memory size)/4.  However all mainstream
> distro kernels for POWER have used a 64kiB page size for at least 10 years.
> 
> So, simply replace this logic with a check that the RMA we've calculated
> based only on guest visible configuration will fit within the host implied
> VRMA limit.  This can break if running HPT guests on a host kernel with
> 4kiB page size.  As noted that's very rare.  There also exist several
> possible workarounds:
>   * Change the host kernel to use 64kiB pages
>   * Use radix MMU (RPT) guests instead of HPT
>   * Use 64kiB hugepages on the host to back guest memory
>   * Increase the guest memory size so that the RMA hits one of the fixed
>     limits before the RMA limit.  This is relatively easy on POWER8 which
>     has a 16GiB limit, harder on POWER9 which has a 1TiB limit.
>   * Decrease guest memory size so that it's below the lower bound on VRMA
>     limit (minimum HPT size is 256kiB, giving a minimum VRAM of 8MiB).
>     Difficult in practice since modern guests tend to want 1-2GiB.
>   * Use a guest NUMA configuration which artificially constrains the RMA
>     within the VRMA limit (the RMA must always fit within Node 0).
> 
> Previously, on KVM, we also temporarily reduced the rma_size to 256M so
> that the we'd load the kernel and initrd safely, regardless of the VRMA
> limit.  This was a) confusing, b) could significantly limit the size of
> images we could load and c) introduced a behavioural difference between
> KVM and TCG.  So we remove that as well.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>



Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>  hw/ppc/spapr.c         | 28 ++++++++++------------------
>  hw/ppc/spapr_hcall.c   |  4 ++--
>  include/hw/ppc/spapr.h |  3 +--
>  3 files changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 069bd04a8d..52c39daa99 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1618,7 +1618,7 @@ void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>      spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
>  }
>  
> -void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
> +void spapr_setup_hpt(SpaprMachineState *spapr)
>  {
>      int hpt_shift;
>  
> @@ -1634,10 +1634,16 @@ void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
>      }
>      spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
>  
> -    if (spapr->vrma_adjust) {
> +    if (kvm_enabled()) {
>          hwaddr vrma_limit = kvmppc_vrma_limit(spapr->htab_shift);
>  
> -        spapr->rma_size = MIN(spapr_node0_size(MACHINE(spapr)), vrma_limit);
> +        /* Check our RMA fits in the possible VRMA */
> +        if (vrma_limit < spapr->rma_size) {
> +            error_report("Unable to create %" HWADDR_PRIu
> +                         "MiB RMA (VRMA only allows %" HWADDR_PRIu "MiB",
> +                         spapr->rma_size / MiB, vrma_limit / MiB);
> +            exit(EXIT_FAILURE);
> +        }
>      }
>  }
>  
> @@ -1676,7 +1682,7 @@ static void spapr_machine_reset(MachineState *machine)
>          spapr->patb_entry = PATE1_GR;
>          spapr_set_all_lpcrs(LPCR_HR | LPCR_UPRT, LPCR_HR | LPCR_UPRT);
>      } else {
> -        spapr_setup_hpt_and_vrma(spapr);
> +        spapr_setup_hpt(spapr);
>      }
>  
>      qemu_devices_reset();
> @@ -2711,20 +2717,6 @@ static void spapr_machine_init(MachineState *machine)
>  
>      spapr->rma_size = node0_size;
>  
> -    /* With KVM, we don't actually know whether KVM supports an
> -     * unbounded RMA (PR KVM) or is limited by the hash table size
> -     * (HV KVM using VRMA), so we always assume the latter
> -     *
> -     * In that case, we also limit the initial allocations for RTAS
> -     * etc... to 256M since we have no way to know what the VRMA size
> -     * is going to be as it depends on the size of the hash table
> -     * which isn't determined yet.
> -     */
> -    if (kvm_enabled()) {
> -        spapr->vrma_adjust = 1;
> -        spapr->rma_size = MIN(spapr->rma_size, 0x10000000);
> -    }
> -
>      /* Actually we don't support unbounded RMA anymore since we added
>       * proper emulation of HV mode. The max we can get is 16G which
>       * also happens to be what we configure for PAPR mode so make sure
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 140f05c1c6..372ba8bd1c 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1456,7 +1456,7 @@ static void spapr_check_setup_free_hpt(SpaprMachineState *spapr,
>          spapr_free_hpt(spapr);
>      } else if (!(patbe_new & PATE1_GR)) {
>          /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
> -        spapr_setup_hpt_and_vrma(spapr);
> +        spapr_setup_hpt(spapr);
>      }
>      return;
>  }
> @@ -1772,7 +1772,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>           * (because the guest isn't going to use radix) then set it up here. */
>          if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
>              /* legacy hash or new hash: */
> -            spapr_setup_hpt_and_vrma(spapr);
> +            spapr_setup_hpt(spapr);
>          }
>          spapr->cas_reboot =
>              (spapr_h_cas_compose_response(spapr, args[1], args[2],
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d5ab5ea7b2..85c33560c3 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -154,7 +154,6 @@ struct SpaprMachineState {
>      SpaprPendingHpt *pending_hpt; /* in-progress resize */
>  
>      hwaddr rma_size;
> -    int vrma_adjust;
>      uint32_t fdt_size;
>      uint32_t fdt_initial_size;
>      void *fdt_blob;
> @@ -772,7 +771,7 @@ int spapr_h_cas_compose_response(SpaprMachineState *sm,
>                                   target_ulong addr, target_ulong size,
>                                   SpaprOptionVector *ov5_updates);
>  void close_htab_fd(SpaprMachineState *spapr);
> -void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
> +void spapr_setup_hpt(SpaprMachineState *spapr);
>  void spapr_free_hpt(SpaprMachineState *spapr);
>  SpaprTceTable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
>  void spapr_tce_table_enable(SpaprTceTable *tcet,
> 

-- 
Alexey

