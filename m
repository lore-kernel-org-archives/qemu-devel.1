Received: from eggs.gnu.org ([2001:4830:134:3::10]:40573)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVfo5-0003ec-O0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVfo1-0004ui-Jl
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:13:33 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:50947 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVfo1-0004td-AJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:13:29 -0400
References: <20170713092100.GD4011@redhat.com>
	<e0a85555-aaa9-c2d0-efc7-8a932ca8a915@kamp.de>
	<20170713140022.GN4011@redhat.com>
	<1f4ca3cc-b17b-b577-f5a7-5d550c387cb5@kamp.de>
	<20170713140711.GO4011@redhat.com>
	<4648fb64-c1ea-0962-0123-2326769a07c2@kamp.de>
	<20170713145801.GP4011@redhat.com>
	<37d97fcb-aa71-1ed4-2134-6d308da7b527@kamp.de>
	<20170713150148.GQ4011@redhat.com>
	<2c5db580-1e3e-9b82-2768-ba2510173387@kamp.de>
	<20170713150652.GR4011@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <07042f09-594a-a288-588b-59c70479c414@kamp.de>
Date: Thu, 13 Jul 2017 17:13:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170713150652.GR4011@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 5/8] block/qcow2: read and write the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com

Am 13.07.2017 um 17:06 schrieb Daniel P. Berrange:
> On Thu, Jul 13, 2017 at 05:02:51PM +0200, Peter Lieven wrote:
>> Am 13.07.2017 um 17:01 schrieb Daniel P. Berrange:
>>> On Thu, Jul 13, 2017 at 05:00:39PM +0200, Peter Lieven wrote:
>>>> Am 13.07.2017 um 16:58 schrieb Daniel P. Berrange:
>>>>> On Thu, Jul 13, 2017 at 04:18:13PM +0200, Peter Lieven wrote:
>>>>>> Okay, so it has to be a mix of QAPI parsing and manual parameter checking,
>>>>>> right?
>>>>> Yeah. It does feel like a valid RFE for QAPI to add a permitted range to
>>>>> 'int' types though, which would simplify the code in future.
>>>>>
>>>>>> I currently have the following:
>>>>>>
>>>>>>        options = qemu_opts_to_qdict(opts, NULL);
>>>>>>        qdict_extract_subqdict(options, &compressopts, "compress.");
>>>>>>        v = qobject_input_visitor_new_keyval(QOBJECT(compressopts));
>>>>>>        visit_start_struct(v, NULL, NULL, 0, &local_err);
>>>>>>        if (local_err) {
>>>>>>            ret= -EINVAL;
>>>>>>            goto finish;
>>>>>>        }
>>>>>>        visit_type_Qcow2Compress_members(v, &compress, &local_err);
>>>>>>        if (local_err) {
>>>>>>            ret= -EINVAL;
>>>>>>            goto finish;
>>>>>>        }
>>>>>>        visit_end_struct(v, NULL);
>>>>>>        visit_free(v);
>>>>>>        QDECREF(compressopts);
>>>>>>        QDECREF(options)
>>>>> Looks good.
>>>>>
>>>>>> And I have the following 2 questions:
>>>>>>     a) I have to specifiy compress.format and compress.level otherwise I will get an error. How can I fix that the settings are optional?
>>>>> Put an '*' as the first character of any field name if it should be optional.
>>>>>
>>>>>>     b) If I just specify a compress.format can I default the compress.level to 0 without an error?
>>>>> I believe you'd get compress.level as 0 automatically for an 'int' type.
>>>> I still face the issue that I now always have to specify a compress.format.
>>>> I tried to solve it like this:
>>> [snip]
>>>
>>> that's not needed if you name the parameter '*level' in the QAPI schema
>> its not needed for the *level, but I still get the error that the format
>> parameter is missing otherwise. And I can't make format optional.
> Surely specifying compress.format is how you turn on compression in the
> first place, so making that optional should not be necessary. eg the
> simple case becomes:
>
>    qemu-img create -f qcow2 -o compress.format=zlib  foo.qcow2 1G
>
> Yes, there is no notion of a "default" format, but IMHO that's a good
> thing - same way with encryption - it requires an explict encrypt.format=luks
> to turn on encryption

Yes, but visit_type_Qcow2Compress_members always returns an error if compress.format
is missing from the options. So I should not call it an error out if compress.format is not in the
options. Thus the check if either compress.format or compress.level is specified at all.

Peter
