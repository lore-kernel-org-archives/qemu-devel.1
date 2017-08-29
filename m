Received: from eggs.gnu.org ([2001:4830:134:3::10]:33080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmgfg-0006VE-TD
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmgfc-0003Rc-O6
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:35:12 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:36140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmgfc-0003R8-JX
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:35:08 -0400
Received: by mail-qt0-x233.google.com with SMTP id v29so14659327qtv.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 06:35:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
	<edd3bb01-dcb5-4741-3fe4-a20a5f64af88@amsat.org>
	<f2a66875-06e8-9304-b20d-aa10e848a245@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c91157c7-6378-579c-b66e-19db518cd58a@amsat.org>
Date: Tue, 29 Aug 2017 10:35:02 -0300
MIME-Version: 1.0
In-Reply-To: <f2a66875-06e8-9304-b20d-aa10e848a245@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 08/29/2017 10:22 AM, Kamil Rytarowski wrote:
> On 29.08.2017 15:10, Philippe Mathieu-Daudé wrote:
>> Hi Fam, Kamil,
>>
>>> On 08/28/2017 02:47 PM, Fam Zheng wrote:
>> [...]
>>>> +        subprocess.check_call([tar_cmd,
>>>> +                               "--exclude-vcs",
>>>> +                               "--exclude=tests/vm/*.img",
>>>> +                               "--exclude=tests/vm/*.img.*",
>>>> +                               "--exclude=*.d",
>>>> +                               "--exclude=*.o",
>>>> +                               "--exclude=docker-src.*",
>>>> +                               "-cf", tarfile, '.'], cwd=data_dir,
>>>
>>> I'm not happy with this command :/
>>> My distrib uses tmpfs for /tmp and suddently the whole X window became
>>> irresponsive until this script failing after filling 8G of /tmp and swap:
>>>
>>> ...
>>> DEBUG:root:Creating archive /tmp/qemu-vm-F7CY9O/data-3a52c.tar for
>>> data dir: .
>>> tar: /tmp/qemu-vm-F7CY9O/data-3a52c.tar: Wrote only 4096 of 10240 bytes
>>> tar: Error is not recoverable: exiting now
>>> Failed to prepare guest environment
>>>
>>> Then I figured out my workdir is full of testing stuff, debug images,
>>> firmwares, coredumps, etc.
>>>
>>> I'll think of another way.
>>
>> Using:
>>
>> (git ls-files; git submodule foreach --recursive "git ls-files | sed
>> s_^_\$sm_path/_" | sed /^Entering/d) > files.txt
>>
>> and:
>>
>>          subprocess.check_call([tar_cmd,
>>                                 "-cf", tarfile,
>>                                 "-v" if self.debug else "",
>>                                 "-T", "files.txt"], cwd=data_dir,
>>                                stdin=self._devnull, stdout=self._stdout)
>>
>> Current /master and submodules generated tarball is ~305MB uncompressed.
>>
>> Kamil do you mind testing this command on NetBSD?
>>
>> (obviously 'files.txt' goes in tmpdir).
>>
> 
> Result:
> 
> http://www.netbsd.org/~kamil/qemu/files.txt

\o/

> I've tested this command line on a checkout from Jul 17th rev. 77031ee1ce4c

Thanks Kamil :)

Fam are you OK using this command instead?

Regards,

Phil.
