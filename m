Received: from eggs.gnu.org ([2001:4830:134:3::10]:37399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoZp-0007gt-2Z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXoZj-0003DK-DH
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:04:13 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:40456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXoZj-0003A3-6H
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:04:07 -0400
Received: by mail-pf0-x243.google.com with SMTP id z24-v6so8131257pfe.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:04:07 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-2-richard.henderson@linaro.org>
	<87o9fxx46d.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <373aa8a7-9bff-4eba-2452-a9df0ac53c61@linaro.org>
Date: Tue, 26 Jun 2018 07:04:03 -0700
MIME-Version: 1.0
In-Reply-To: <87o9fxx46d.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 01/35] target/arm: Implement SVE Memory
 Contiguous Load Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 06/26/2018 02:55 AM, Alex Bennée wrote:
>> +/* Convert a 2-bit memory size (msz) to a 4-bit data type (dtype)
>> + * with unsigned data.  C.f. SVE Memory Contiguous Load Group.
>> + */
>> +static inline int msz_dtype(int msz)
>> +{
>> +    static const uint8_t dtype[4] = { 0, 5, 10, 15 };
>> +    return dtype[msz];
>> +}
> I'm a little confused by the magic numbers in dtype[4], do they map
> directly to dtype_mop[]?
> 

Well, yes, this would sort of be the inverse of dtype_mop.

My intent with the comment was to point you to the table within
the SVE Memory - Contiguous Load Group section of
the Index by Encoding page:

DDI0584A_d_SVE/SVE_xml/xhtml/encodingindex.html#sve_memcld

and that I'm picking out the unsigned loads of size 1, 2, 4, 8.

Do you have a suggested re-wording?

I should note that *most* load operations use a 4-bit dtype field, except for
the non-temporal loads, which use a 2-bit msz field.  Since qemu does not care
about the memory hierarchy, by mapping msz back into dtype I can forward the
implementation directly to the normal load routines.


r~
