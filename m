Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196682071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frKHD5PM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196682071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKtg-0000nm-7x
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnKh0-0008Cd-4E
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:32:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnKgy-0000cM-DI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592825567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+gcZ6YVNGevABBWhvC1ing3cwbhj3IIwuhk2UPg42/s=;
 b=frKHD5PM7/WE4RmXxjs4yh+J3Z/Va8vjBv1LmsOlvb2pA3/B5dY/2wNlDZ48j+LV0zbb62
 0Y1azn+ItIpZj2fqgUrUSFJBLS6Jkoz6ZKRWEM1kTzoqXIzn8XM9T4+DhXgjLqUC750NQx
 3UagPGNvUEuch9vh17Th6bgPL8yl1WU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-ALoHpcp-PkipuMz2n82xOQ-1; Mon, 22 Jun 2020 07:32:44 -0400
X-MC-Unique: ALoHpcp-PkipuMz2n82xOQ-1
Received: by mail-wr1-f70.google.com with SMTP id r5so10750140wrt.9
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 04:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+gcZ6YVNGevABBWhvC1ing3cwbhj3IIwuhk2UPg42/s=;
 b=Q7UPMhi3yoPGjditqhCiUyy0LDoswu6rFzabSIUkQ5hTVMTJ8EalbPxIKfQvBqUnMF
 Uehpr/rUNcmlopYiZeo570ItAzpurlvl1wbjqA9CNf/ZUm6/NuNYg1utg+56pQqb7xPQ
 suNsUuhTjtdz+IUz1xvisS+LmwgpMv0e915Pc87w0lXMqCRqCE/N9IHDykmRPwAXMstg
 Uk/R3QnDxjU2P2GnlhXpTQ/aopb7O67Ui1bs/UrEJ2nEDJOaaqUYKcRsIf8kCS5+s7YX
 050CtyilP4US0fLJ8cXGCOF+VxQ5KoL6s8qMIx7Qz6qET6Yo7H35UWrPizzcdj7gP2eX
 oABQ==
X-Gm-Message-State: AOAM532TMXWzs8Zj5mT39Zla5eudiK0rs9zcL/RDWYuTp5HJzAhgBG2z
 BSjqYT0g0eOho+EHtiSPopOvshQV83Xv7msXLJgwTfD6UhX/ADXGayF6pQr+Ssw7eGFIPcAC5NJ
 g3OHDnTRCPprIYqQ=
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr3426030wml.82.1592825562274; 
 Mon, 22 Jun 2020 04:32:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD7LmIwj/v1fK8pk+HbxIW0CNJMx03f6VRVPT4894RSGdtAse0ShaFzpdzYPev/aTd8A4wvQ==
X-Received: by 2002:a05:600c:2116:: with SMTP id
 u22mr3426001wml.82.1592825562042; 
 Mon, 22 Jun 2020 04:32:42 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z25sm1566806wmk.28.2020.06.22.04.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 04:32:41 -0700 (PDT)
Subject: Re: [PATCH v3 12/16] python/machine.py: Add _qmp access shim
To: Kevin Wolf <kwolf@redhat.com>
References: <20200604202236.25039-1-jsnow@redhat.com>
 <20200604202236.25039-13-jsnow@redhat.com>
 <659c7e95-54c3-dc20-02e3-86ce4ca74a5f@redhat.com>
 <CAP+75-UDM0zxzBWze2NvuJPQ3ezZDn3r-SsrM2q_7JU3ANiYaA@mail.gmail.com>
 <20200622102342.GB5707@linux.fritz.box>
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
Message-ID: <8678f5fe-4870-cd10-c1c7-52db40fa30cb@redhat.com>
Date: Mon, 22 Jun 2020 13:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622102342.GB5707@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 12:23 PM, Kevin Wolf wrote:
> Am 20.06.2020 um 10:20 hat Philippe Mathieu-DaudÃ© geschrieben:
>> On Sat, Jun 20, 2020 at 10:14 AM Philippe Mathieu-DaudÃ©
>> <philmd@redhat.com> wrote:
>>>
>>> On 6/4/20 10:22 PM, John Snow wrote:
>>>> Like many other Optional[] types, it's not always a given that this
>>>> object will be set. Wrap it in a type-shim that raises a meaningful
>>>> error and will always return a concrete type.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  python/qemu/machine.py | 12 +++++++++---
>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>>>> index d8289936816..a451f9000d6 100644
>>>> --- a/python/qemu/machine.py
>>>> +++ b/python/qemu/machine.py
>>>> @@ -118,7 +118,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>>>>          self._events = []
>>>>          self._iolog = None
>>>>          self._qmp_set = True   # Enable QMP monitor by default.
>>>> -        self._qmp = None
>>>> +        self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] = None
>>>>          self._qemu_full_args = None
>>>>          self._temp_dir = None
>>>>          self._launched = False
>>>> @@ -285,7 +285,7 @@ def _pre_launch(self):
>>>>              if self._remove_monitor_sockfile:
>>>>                  assert isinstance(self._monitor_address, str)
>>>>                  self._remove_files.append(self._monitor_address)
>>>> -            self._qmp = qmp.QEMUMonitorProtocol(
>>>> +            self._qmp_connection = qmp.QEMUMonitorProtocol(
>>>>                  self._monitor_address,
>>>>                  server=True,
>>>>                  nickname=self._name
>>>> @@ -455,7 +455,13 @@ def set_qmp_monitor(self, enabled=True):
>>>>              self._qmp_set = True
>>>>          else:
>>>>              self._qmp_set = False
>>>> -            self._qmp = None
>>>> +            self._qmp_connection = None
>>>> +
>>>> +    @property
>>>> +    def _qmp(self) -> qmp.QEMUMonitorProtocol:
>>>> +        if self._qmp_connection is None:
>>>> +            raise QEMUMachineError("Attempt to access QMP with no connection")
>>>> +        return self._qmp_connection
>>>>
>>>>      @classmethod
>>>>      def _qmp_args(cls, _conv_keys: bool = True, **args: Any) -> Dict[str, Any]:
>>>>
>>>
>>> This patch breaks the EmptyCPUModel test:
>>>
>>> (043/101) tests/acceptance/empty_cpu_model.py:EmptyCPUModel.test:
>>> ERROR: Attempt to access QMP with no connection (0.03 s)
>>
>> Fixed with:
>>
>> -- >8 --
>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>> index ba6397dd7e..26ae7be89b 100644
>> --- a/python/qemu/machine.py
>> +++ b/python/qemu/machine.py
>> @@ -480,7 +480,7 @@ def set_qmp_monitor(self, enabled: bool = True) -> None:
>>
>>      @property
>>      def _qmp(self) -> qmp.QEMUMonitorProtocol:
>> -        if self._qmp_connection is None:
>> +        if self._qmp_set and self._qmp_connection is None:
>>              raise QEMUMachineError("Attempt to access QMP with no connection")
>>          return self._qmp_connection
>>
>> ---
>>
>> Does that sound reasonable to you?
> 
> Wouldn't that make the return type Optional[qmp.QEMUMonitorProtocol]?
> Maybe this is what we want, but then we don't need the shim that this
> patch adds but can just declare the variable this way.
> 
> And why does the feeling code even try to acess _qmp when _qmp_set is
> False? Shouldn't it first check whether it's even valid?
> 
> Or maybe going a step back, why do we even have a separate _qmp_set
> instead of only using None for _qmp?

Better indeed.

John, at this point from a maintenance perspective it is easier
if you respin the series (and please, run the Travis-CI tests).

Regards,

Phil.


