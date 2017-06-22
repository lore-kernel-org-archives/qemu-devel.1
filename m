Received: from eggs.gnu.org ([2001:4830:134:3::10]:38512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dO4R9-0001DH-29
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dO4R8-00077b-72
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 11:54:27 -0400
In-Reply-To: <CAFEAcA-EgM8rDvOBVRAf2Sud-7ivVpaXUhKckZiqs-YriixtHQ@mail.gmail.com>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
	<alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
	<F3D7AC88-099F-432D-B46F-97F2A6F7B0E3@gmail.com>
	<f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
	<CAFEAcA-72bvtKsPHttUizYj8EvZJDfjUda7CeZe-tpRk73+NXw@mail.gmail.com>
	<CE257476-FBA4-4579-A558-495797786922@gmail.com>
	<CAFEAcA85obZ5eD7Lpydi4vH4DVat6xpaskVumodv2u1Hzz6CCg@mail.gmail.com>
	<4BD44623-AD16-4D5D-BF51-15521035E974@gmail.com>
	<CAFEAcA-EgM8rDvOBVRAf2Sud-7ivVpaXUhKckZiqs-YriixtHQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B1B47EB1-719A-4B33-9591-07C091752172@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 22 Jun 2017 11:54:14 -0400
Subject: Re: [Qemu-devel] [Qemu-ppc] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, BALATON Zoltan <balaton@eik.bme.hu>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>


On Jun 22, 2017, at 3:25 AM, Peter Maydell wrote:

> On 22 June 2017 at 03:54, G 3 <programmingkidx@gmail.com> wrote:
>> The advantage a test image would have is the user doesn't have to  
>> worry
>> about compiling a test using a cross compiler. Everything the user  
>> would
>> need to test QEMU is already inside the image file (hopefully).
>>
>> Is the setup you want something like running 'make test' ? I  
>> imagine binary
>> files included with QEMU would test the emulated CPU. There would  
>> be no need
>> to cross compile anything.
>
> I want our tests to be easy to add new tests for, and easy
> for anybody to recreate the binary files. Certainly providing
> pre-built binaries would be helpful (faster than rebuilding
> whole system images), but we must have an automated mechanism
> for saying "build this image from sources" too, so that if
> we want to update the test program later it's easy to do that,
> or if we want to add a second test that's like the first
> one but slightly modified we can easily do that too.

So what you want is a test system that is easy to write. Maybe as  
easy as writing a python script? What I thought up is a collection of  
functions that implement assembly language code. Say you want to make  
a test that runs the fadds instruction. You might run it like this:

def my_float_test:
	inputA = 0.5
	inputB = 0.25
	result = fadds(inputA, inputB)
	if result != 0.75:
		print("Error with fadds calculation")
	if get_FPSCR() != expect_fpscr_value:
		print("FPSCR error")


Then all we would be left to figure out is how to turn this code into  
a mach-o or elf binary. Then again this might not be a requirement.  
What if we had python running on the guest. The above code might work  
as is. No cross compiling required.

Implementing the callable assembly language code from python could be  
done using a single command-line program. This program would simply  
receive its arguments and return a value. If this program was called  
assembly _adapter, it would run like this:

% assembly_adapter fadds 0.5 0.25

The return value of this command is where we would see the result.  
This command-line program would only need to be compiled once and  
included with QEMU. The format of this program's arguments would be  
something like this:  <assembly instruction> <input> <input>

This input would probably work for most instructions but doesn't  
necessarily need to be applied to all instructions.

Would this kind of system be something you want? 
