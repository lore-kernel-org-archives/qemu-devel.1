Received: from eggs.gnu.org ([2001:4830:134:3::10]:37756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cSMPn-0001zT-CM
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 06:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cSMPm-0001TP-9T
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 06:22:31 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cSMPm-0001S2-3x
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 06:22:30 -0500
Received: by mail-io0-x244.google.com with SMTP id c80so8078343iod.1
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 03:22:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <011014c2-1129-cd48-f13d-66d7951d3e3c@linux.intel.com>
References: <5878435d.54b31c0a.39a7b.4e93@mx.google.com>
	<011014c2-1129-cd48-f13d-66d7951d3e3c@linux.intel.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 14 Jan 2017 19:22:28 +0800
Message-ID: <CAKXe6SJXWzu2pTZz_vRGic4ZomPcVGVOfOvig43=8ZoZet0cRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] nvdimm: allow read/write zero-size
 namespace label
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>

Hello Guangrong,


2017-01-13 17:00 GMT+08:00 Xiao Guangrong <guangrong.xiao@linux.intel.com>:

>
>
> On 01/13/2017 11:02 AM, Li Qiang wrote:
>
>> From: Li Qiang <liqiang6-s@360.cn>
>>
>> The spec doesn't say the namespace label can't be zero
>> when read/write it. As this is no harmful, just allow
>> it.
>>
>>
> WHY?
>
> The spec said that the label should be at least 128K.
>

Yes, the label size has a limit, but in NVDIMM_DSM_Interface_Example.pdf
section 4.5.1
When the guest get namespace label data, the 'Length' is not limited, if it
is 0, it will trigger
this assert.

static void nvdimm_validate_rw_label_data(NVDIMMDevice *nvdimm, uint64_t
size,
                                        uint64_t offset)
{
    assert((nvdimm->label_size >= size + offset) && (offset + size >
offset));
}

Though I don't know what the exact behavior of this action in real
hardware. I just think it should not
trigger assert and exit when the guest get 0-size label data.

Anyway, this is just a suggestion, If my understand is wrong, just ignore
this.

Thanks.
