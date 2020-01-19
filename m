Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F96CC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F20205F4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6bWuHy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F20205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it8gd-0001Sb-I4
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 06:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8g2-00012Y-Ph
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8g1-0005kx-Ke
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:23:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8g1-0005kb-Cd
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:23:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so11595248wmb.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 03:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ucUIpubvjkOCnZu7ztZU2jv49LKqB4JfC0G5Va7uEUo=;
 b=O6bWuHy/lf0ltGx2TNvidR7UV7KXTXrUfC30skcgCMXoF5Fv5JLlHZ4Z54lSbxSxJW
 BoSLEwolkCQFPnIJzxu+jHS/jmSUM4ou0+BMk4Xdhs6pThn9/mS/r2xWUGO0OR/6AeJJ
 AarhYDSgegu8LBV1zy6hfO2B+9M9y9qWnQvOuF11X1hQhViT9W9RB7AJkaWjDcXq5rP9
 h1SIQdONQ40Hj5TALbGm8xzw52mJz3Ji/gVB5u5LNIkSapEsOtPCGI7fMy2LvXOMFhUY
 fIoQ/cff/2IVsreb0Q6BoHWRooEpINoYYji4Z8197DI7+sxw2nzSzbhN/1iadRXDUrGz
 rQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ucUIpubvjkOCnZu7ztZU2jv49LKqB4JfC0G5Va7uEUo=;
 b=Qjbqjk4eTPl5ORhM42CTJtEUucnfU0404AstcruppxVF5b42lgpeqkCidL2mZSLFZ9
 KkMrDWmECU4quuqdvgQ608K79bXQJJ4zTxxxb94GqSodxL8+aziW9BLiG6SxRrmwjrd9
 oyNVgQTWJL8RbnyhSnZteFHj2X4n3LtvUSlPfSj8ltX+93eT8XSAud5CcyM2aG9JYom6
 z59R87tp30ManUREWbFBZzreEVGhAoqygU4JaE9p+tSIU6+UmioJ3VuIjslsjm1CwSMZ
 KsqRE7R7eXalmpe4qz4jvkhOKPneyyeKM+DgY+Qj14lfrJybrdly/kYKub3RpimfRj86
 ajUQ==
X-Gm-Message-State: APjAAAUklFlHS1n1CBy+7qUSlVnWZMMnBQgkJ1lD329khAH1qStNT8h+
 5JAmys7ZcFWI0sRfOhRSCJ8=
X-Google-Smtp-Source: APXvYqycwF6FxPLQ8Axbf5KPOZkG/+Y7CxO4jJZfrrAJZNeiRK01zhwW4o8fNj8iq8jUTmw5WuWybQ==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr14566492wmg.163.1579433011962; 
 Sun, 19 Jan 2020 03:23:31 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id h2sm43657422wrv.66.2020.01.19.03.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 03:23:31 -0800 (PST)
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20200116202558.31473-1-armbru@redhat.com>
 <163735a5-b8d0-e657-86b2-a3921d754381@redhat.com>
 <87tv4ul5nd.fsf@dusky.pond.sub.org>
 <b8976470-1fe3-f380-8bde-af2d7c29c9ab@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <4179b4ec-00cd-6e09-7a98-fab422075d72@amsat.org>
Date: Sun, 19 Jan 2020 12:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b8976470-1fe3-f380-8bde-af2d7c29c9ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/18/20 9:33 AM, Philippe Mathieu-Daudé wrote:
> On 1/17/20 11:49 AM, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 16/01/2020 21.25, Markus Armbruster wrote:
>>>> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
>>>> modules" switched QAPISchema.visit() from
>>>>
>>>>      for entity in self._entity_list:
>>>>
>>>> effectively to
>>>>
>>>>      for mod in self._module_dict.values():
>>>>          for entity in mod._entity_list:
>>>>
>>>> Visits in the same order as long as .values() is in insertion order.
>>>> That's the case only for Python 3.6 and later.  Before, it's in some
>>>> arbitrary order, which results in broken generated code.
>>>>
>>>> Fix by making self._module_dict an OrderedDict rather than a dict.
>>>>
>>>> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>   scripts/qapi/schema.py | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>>>> index 0bfc5256fb..5100110fa2 100644
>>>> --- a/scripts/qapi/schema.py
>>>> +++ b/scripts/qapi/schema.py
>>>> @@ -795,7 +795,7 @@ class QAPISchema(object):
>>>>           self.docs = parser.docs
>>>>           self._entity_list = []
>>>>           self._entity_dict = {}
>>>> -        self._module_dict = {}
>>>> +        self._module_dict = OrderedDict()
>>>>           self._schema_dir = os.path.dirname(fname)
>>>>           self._make_module(None) # built-ins
>>>>           self._make_module(fname)
>>>>
>>>
>>> Thanks, this fixes the problems on Travis for me!
>>>
>>> Tested-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

And per https://www.mail-archive.com/qemu-devel@nongnu.org/msg671745.html:

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

>>> Peter, could you maybe apply this directly to the master branch as a
>>> build fix?
>>
>> The commit message isn't quite right: s/Visits in the same order/Visits
>> modules in the same order/.  Peter, want me to respin for that?
> 
> Since it is a single patch, it shouldn't be too much work to respin :)
> 
> I agree this patch is candidate for direct fix on /master.
> 
> Thanks,
> 
> Phil.
> 
> 

