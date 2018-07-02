Received: from eggs.gnu.org ([2001:4830:134:3::10]:51346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa0c6-0002ae-TD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa0c6-0004BW-37
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:19:38 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:38202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa0c5-0004BP-Tg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:19:38 -0400
Received: by mail-qt0-x244.google.com with SMTP id c5-v6so14096325qth.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:19:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180628153535.1411-1-f4bug@amsat.org>
	<20180628153535.1411-3-f4bug@amsat.org>
	<20180702071823.GJ26002@lemon.usersys.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fb49e069-e485-268d-6150-06910b416685@amsat.org>
Date: Mon, 2 Jul 2018 12:19:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180702071823.GJ26002@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] tests/vm: Add a dependency to qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 07/02/2018 04:18 AM, Fam Zheng wrote:
> On Thu, 06/28 12:35, Philippe Mathieu-Daudé wrote:
>> Before the first use, the VM image are resized with qemu-img.
>>
>> Add a dependency to the qemu-img tool to fix:
>>
>>   $ make vm-build-ubuntu.i386
>>   Traceback (most recent call last):
>>     File "source/qemu/tests/vm/basevm.py", line 236, in main
>>       return vm.build_image(args.image)
>>     File "tests/vm/ubuntu.i386", line 67, in build_image
>>       subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>>   OSError: [Errno 2] No such file or directory
>>   tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386.img' failed
>>   make: *** [tests/vm/ubuntu.i386.img] Error 2
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/vm/Makefile.include | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
>> index 5daa2a3b73..e5e8146267 100644
>> --- a/tests/vm/Makefile.include
>> +++ b/tests/vm/Makefile.include
>> @@ -17,10 +17,13 @@ vm-test:
>>  
>>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>>  
>> +$(IMAGE_FILES): qemu-img$(EXESUF)
> 
> No, please don't do this. Let's keep on supporting vm tests from a clean source
> tree. Similar to qemu_bin, this can be handled in basevm.py.

OK.

>> +
>>  tests/vm/%.img: $(SRC_PATH)/tests/vm/% \
>>  		$(SRC_PATH)/tests/vm/basevm.py \
>>  		$(SRC_PATH)/tests/vm/Makefile.include
>>  	$(call quiet-command, \
>> +		PATH=$(PATH):. \
>>  		$< \
>>  		$(if $(V)$(DEBUG), --debug) \
>>  		--image "$@" \
>> -- 
>> 2.18.0
>>
> 
