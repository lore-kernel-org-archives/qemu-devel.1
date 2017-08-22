Received: from eggs.gnu.org ([2001:4830:134:3::10]:40791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkA5w-0008CB-NW
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkA5r-0006Fg-OU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:23:52 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:34807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkA5r-0006FI-K7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:23:47 -0400
Received: by mail-qk0-x234.google.com with SMTP id u139so97799996qka.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 07:23:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170822044155.2451-1-famz@redhat.com>
	<20170822044155.2451-4-famz@redhat.com>
	<51a26b62-8ce8-6733-908b-3481a110663e@amsat.org>
	<20170822140000.GF3210@lemon>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf40501d-a61f-6e48-687c-fff4b9db47c4@amsat.org>
Date: Tue, 22 Aug 2017 11:23:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170822140000.GF3210@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On 08/22/2017 11:00 AM, Fam Zheng wrote:
> On Tue, 08/22 08:19, Philippe Mathieu-Daudé wrote:
>>> +    def add_source_dir(self, data_dir):
>>> +        name = "data-" + hashlib.sha1(data_dir).hexdigest()[:5]
>>> +        tarfile = os.path.join(self._tmpdir, name + ".tar")
>>> +        logging.debug("Creating archive %s for data dir: %s", tarfile, data_dir)
>>> +        subprocess.check_call(["tar", "--exclude-vcs",
>>
>> --exclude-vcs-ignores will process .gitignore,
> 
> Sounds useful, thanks!
> 
>> you can also list with 'git ls-files',
>> or generate tarball with scripts/make-release
> 
> They won't handle submodules, will they?

"git ls-files --recurse-submodules"

This way you can avoid the --exclude-vcs-ignores which is too recent for 
NetBSD as remarked Kamil, and avoid the tar --exclude=

>>
>>> +                               "--exclude=tests/vm/*.img",
>>> +                               "--exclude=tests/vm/*.img.*",
>>> +                               "--exclude=*.d",
>>> +                               "--exclude=*.o",
>>> +                               "--exclude=docker-src.*",
>>> +                               "-cf", tarfile, '.'], cwd=data_dir,
>>> +                              stdin=self._devnull, stdout=self._stdout)
>>> +        self._data_args += ["-drive",
>>> +                            "file=%s,if=none,id=%s,cache=writeback,format=raw" % \
>>> +                                    (tarfile, name),
>>> +                            "-device",
>>> +                            "virtio-blk,drive=%s,serial=%s,bootindex=1" % (name, name)]
>>
>> what about mounting readonly via '-device virtio-9p-pci' (not using
>> tarball)?
>>
> 
> It doesn't work. That way an out-of-tree build is required in the guest, but if
> an in-tree build has been done in host side, out-of-tree builds fail.  Also the
> performance will be much worse, I believe: untar is sequential read, and after
> that everything is in the guest page cache; with virtio-9p, there will be a
> large amount of "random" requests between guest and host.

Indeed you are correct, I didn't think of it, thank to remember me that :)
