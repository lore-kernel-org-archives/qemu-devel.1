Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofF8-0006X9-4b
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofF3-0005Jj-Hz
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:27:58 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:38330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dofF3-0005HK-EP
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:27:53 -0400
Received: by mail-qk0-x22c.google.com with SMTP id n64so12611890qki.5
	for <qemu-devel@nongnu.org>; Sun, 03 Sep 2017 17:27:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
Date: Sun, 3 Sep 2017 21:27:49 -0300
MIME-Version: 1.0
In-Reply-To: <9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org

On 09/03/2017 02:05 PM, Laurent Vivier wrote:
> Le 03/09/2017 à 18:31, Kamil Rytarowski a écrit :
>> GCC 4.7.2 on SunOS reports that the values assigned to array members are not
>> real constants:
>>
>> target/m68k/fpu_helper.c:32:5: error: initializer element is not constant
>> target/m68k/fpu_helper.c:32:5: error: (near initialization for 'fpu_rom[0]')
>> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>>
>> Convert the array to switch() to workaround the issue.
> 
> I don't like the idea. It's really an array and should be managed as an
> array.

I agree with Laurent.

> 
> Could you try to use make_floatx80_init() instead of make_floatx80() ?

I guess the problem comes from the macro which cast as not const:

#define make_floatx80(exp, mant) ((floatx80) { mant, exp })

make_floatx80_init() doesn't cast so it might work,
else we could add a macro such const_floatx80():

#define const_floatx80(exp, mant) ((const floatx80) { mant, exp })
