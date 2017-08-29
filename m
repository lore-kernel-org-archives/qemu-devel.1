Received: from eggs.gnu.org ([2001:4830:134:3::10]:53427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmgIE-00054Q-DD
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmgIA-00081J-BT
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:10:58 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:35791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmgIA-00081C-7d
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:10:54 -0400
Received: by mail-qt0-x235.google.com with SMTP id x36so14411092qtx.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 06:10:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
Message-ID: <edd3bb01-dcb5-4741-3fe4-a20a5f64af88@amsat.org>
Date: Tue, 29 Aug 2017 10:10:48 -0300
MIME-Version: 1.0
In-Reply-To: <de606e2a-7f5e-0625-79dd-a828ea3d5fe9@amsat.org>
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com

Hi Fam, Kamil,

> On 08/28/2017 02:47 PM, Fam Zheng wrote:
[...]
>> +        subprocess.check_call([tar_cmd,
>> +                               "--exclude-vcs",
>> +                               "--exclude=tests/vm/*.img",
>> +                               "--exclude=tests/vm/*.img.*",
>> +                               "--exclude=*.d",
>> +                               "--exclude=*.o",
>> +                               "--exclude=docker-src.*",
>> +                               "-cf", tarfile, '.'], cwd=data_dir,
> 
> I'm not happy with this command :/
> My distrib uses tmpfs for /tmp and suddently the whole X window became 
> irresponsive until this script failing after filling 8G of /tmp and swap:
> 
> ...
> DEBUG:root:Creating archive /tmp/qemu-vm-F7CY9O/data-3a52c.tar for data 
> dir: .
> tar: /tmp/qemu-vm-F7CY9O/data-3a52c.tar: Wrote only 4096 of 10240 bytes
> tar: Error is not recoverable: exiting now
> Failed to prepare guest environment
> 
> Then I figured out my workdir is full of testing stuff, debug images, 
> firmwares, coredumps, etc.
> 
> I'll think of another way.

Using:

(git ls-files; git submodule foreach --recursive "git ls-files | sed 
s_^_\$sm_path/_" | sed /^Entering/d) > files.txt

and:

         subprocess.check_call([tar_cmd,
                                "-cf", tarfile,
                                "-v" if self.debug else "",
                                "-T", "files.txt"], cwd=data_dir,
                               stdin=self._devnull, stdout=self._stdout)

Current /master and submodules generated tarball is ~305MB uncompressed.

Kamil do you mind testing this command on NetBSD?

(obviously 'files.txt' goes in tmpdir).

Regards,

Phil.
