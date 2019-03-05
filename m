Received: from eggs.gnu.org ([209.51.188.92]:43913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EGz-0007W4-GM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1EGn-0004tK-VB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:54:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1EGh-0004oQ-W3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:54:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so10481307wrx.2
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:54:19 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-12-armbru@redhat.com>
	<a20fe845-4f14-4f23-7feb-bb7ca899c2d5@redhat.com>
	<878sxt5l31.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f37147d9-af24-4625-502e-1a51c3fa9a69@redhat.com>
Date: Tue, 5 Mar 2019 18:54:17 +0100
MIME-Version: 1.0
In-Reply-To: <878sxt5l31.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/11] pflash: Clean up after commit
 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, qemu-ppc@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 3/5/19 5:42 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> Hi Markus,
>>
>> On 2/26/19 8:34 PM, Markus Armbruster wrote:
>>> QOMification left parameter @size unused in pflash_cfi01_register()
>>> and pflash_cfi02_register().  Obviously, @size should match
>>> @sector_len and @nb_blocs, i.e. size == sector_len * nb_blocs.  All
>>> callers satisfy this.
>>>
>>> Remove @nb_blocs and compute it from @size and @sector_len.
>>
>> The pflash devices are simplistically modelled has having a single
>> sector size. This is not true for real hw (pflash have different sector
>> sizes). It is however true for the unofficial VirtPFlash device, which
>> doesn't have any spec.
>>
>> The only valid parameter is @size. The @sector_len and @nb_blocs don't
>> match the hardwares. QEMU @sector_len is currently "The biggest
>> sector_size the device has" and QEMU @nb_blocs is really "@size /
>> @sector_len", although it doesn't match the nb_blocs the hardware has.
>>
>> I don't disagree with the patch content, but the description is not
>> accurate. We can indeed drop the @nb_blocs argument because we model an
>> unique sector size, thus we can calculate "@nb_blocs = @size /
>> @sector_len" in the model.
>>
>> With the patch description fixed:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Let me try to fix it.
> 
>     Our pflash devices are simplistically modelled has having
>     "num-blocks" sectors of equal size "sector-length".  Real hardware
>     commonly has sectors of different sizes.  How our "sector-length"
>     property is related to the physical device's multiple sector sizes
>     is unclear.
> 
>     Helper functions pflash_cfi01_register() and pflash_cfi02_register()
>     create a pflash device, set properties including "sector-length" and
>     "num-blocks", and realize.  They take parameters @size, @sector_len
>     and @nb_blocs.
> 
>     QOMification left parameter @size unused.  Obviously, @size should
>     match @sector_len and @nb_blocs, i.e. size == sector_len * nb_blocs.
>     All callers satisfy this.
> 
>     Remove @nb_blocs and compute it from @size and @sector_len.
> 
> D'accord?

Oui, parfait!
