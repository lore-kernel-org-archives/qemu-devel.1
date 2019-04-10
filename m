Received: from eggs.gnu.org ([209.51.188.92]:49360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5k4-0002mv-1g
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5k2-000346-N3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:25:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hE5k2-00033h-EN
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:25:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so1242292wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 22:25:46 -0700 (PDT)
References: <20190409174018.25798-1-armbru@redhat.com>
	<CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <68a71d55-a7e1-f308-ef6c-8d8f58749bbb@redhat.com>
Date: Wed, 10 Apr 2019 07:25:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 4/9/19 10:08 PM, Peter Maydell wrote:
> On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>> computation of @dt_size overflows to a negative number, which then
>> gets converted to a very large size_t for g_malloc0() and
>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>> succeeds and load_image_size() survives, we'd assign the negative
>> number to *sizep.  What that would do to the callers I can't say, but
>> it's unlikely to be good.
>>
>> Fix by rejecting images whose size would overflow.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> I think this patch is missing some attributions for the
> security researchers who found the issue initially.
> PJP's patch for this from a couple of weeks back has a
> reported-by credit:
> https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/

Oh I missed that thread while on PTO. This answers my "how did you
figure that out?" question :)

Thanks,

Phil.
