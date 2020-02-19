Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C54C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA622064C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA622064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Lhd-0000vg-66
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 04:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4Lgn-0000Ia-Ko
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4Lgm-000617-KU
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 04:30:41 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4Lgh-0005tP-4K; Wed, 19 Feb 2020 04:30:36 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McpeM-1jeEjN3zuM-00Zu53; Wed, 19 Feb 2020 10:30:16 +0100
Subject: Re: [PATCH 3/3] hw/xtensa/xtfpga:fix leak of fdevice tree blob
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 jcmvbkbc@gmail.com, crwulff@gmail.com, marex@denx.de,
 edgar.iglesias@gmail.com, david@gibson.dropbear.id.au
References: <20200218091154.21696-1-kuhn.chenqun@huawei.com>
 <20200218091154.21696-4-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <43b55e06-cc95-9e12-d3f6-fc03a702d28b@vivier.eu>
Date: Wed, 19 Feb 2020 10:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218091154.21696-4-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D6msGcNANjzeYJ5v+VJqXTreD9w9Qa4GTl4jc7ysJqV8X2PcF/W
 FQ1vXqLzEU/Z9eNhvW1oWpgAXBCGGGvzhGuHK2meubolzXEktG0E6gVEWXjpfnT2aPLzPjG
 7mXLdSswycst93uLLHPcM/n71rmfmuSZtyr3bza4l+cbkAoYe1QGs2evdgB7lFvjVNk5/gD
 pBnibNnPxapQqcZBhFVbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OA7l5i/EMx0=:RCgOQyMral7F96SojKWOkQ
 Ho8sy2CQBbfgzninxK4dDMOYYToaUylv+Crhije/4vNYYNDGoaK1V5BrInxPpL4PpMB051/LR
 wzuoeaGltgu2ZKo+4q/jCwMWTUnwuHhQRQLKoaXvLbD3HlDBj7Jy5V8qZX4kKRqCrAH9nwrWw
 /QYX1GTkUExIO46EmOSPzyWgzTm0RQKs6ZZCMTG2elIscyIkGRuOItATHIj36tgaPybcmsGdE
 I5Db3XrRkmK1EgHhiSctqwMmPIA/x716owDt3QACApWNLbGwdxfh9LwwEnBAdi979XWh0E1VA
 BAfTpUtX4GRsSCtCT18mUqJmVrsNS01PF+35U+9rhAoXIcby8fUxdJIXKsmgPyGXCEUvyCA2s
 ClL7wtrE6iu2M6c8aEMy6ICGyzIzGdXw77KNobln83aK+V2yMxQcvwkpnsO0J5ObdBxImrlJR
 7dbp+3lon4M3+F+g7/j+8sRY5cXTMLedNNwGPBq+wlbb/geUbGe6NThL4eK7qZls0HurgkrmQ
 JxwE3yH79pIsuAoG2EZNin00VdyWq/XJCGxE+8VYVsRaMKkvUWYQQYGawY/TwxIFOyqMjVCGf
 gd5KgTFhOPava+4DxJcUBBl9TSN73GEGaVj6GIgaINkzlcWK0gJa6Z0vq0T0edeEWgGFYxOMY
 eZwwkc9+BRISeH+AamQ+PO05QTFhZQJIctDakjc7QIT37uW1DT+M+4OKpzDaqVdK7C9/1VXXc
 JXABc+xiALwe95+CBFqHclFfUm2xa6U1AWPZTn5fWHGB/Bdquq3uOwEveSqXIoWyYEFUwF6lA
 ywA8zmvXFdKfnlHeTCMICozayN8CvmV09Mfqx8tY6CGCiBQqN/xhWCGDhx26gBA6yus77rV
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, pannengyuan@huawei.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/02/2020 à 10:11, kuhn.chenqun@huawei.com a écrit :
> From: Chen Qun <kuhn.chenqun@huawei.com>
> 
> The device tree blob returned by load_device_tree is malloced.
> We should free it after cpu_physical_memory_write().
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
>  hw/xtensa/xtfpga.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
> index 8e2dd1327a..60ccc74f5f 100644
> --- a/hw/xtensa/xtfpga.c
> +++ b/hw/xtensa/xtfpga.c
> @@ -380,6 +380,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
>              cur_tagptr = put_tag(cur_tagptr, BP_TAG_FDT,
>                                   sizeof(dtb_addr), &dtb_addr);
>              cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
> +            g_free(fdt);
>          }
>  #else
>          if (dtb_filename) {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

