Received: from eggs.gnu.org ([2001:4830:134:3::10]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dsadQ-0005ZJ-7a
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dsadM-0007Pq-VN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:21:16 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:54010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dsadM-0007Pd-Qh
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:21:12 -0400
Received: by mail-it0-f54.google.com with SMTP id 85so1511416ith.2
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 13:21:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170914201853.GC23492@localhost.localdomain>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-7-apahim@redhat.com>
	<20170905031853.GN22515@lemon.lan>
	<CALAZnb1Lxu8jHWYM6f76RWGOOrGgq9L8sfKVceR4ygZC1NxyXQ@mail.gmail.com>
	<20170914194610.GB23492@localhost.localdomain>
	<CALAZnb3Gwr1kkAZnkysShGzT19EC4aqQ6ThXjtAQRm2PJqCqdA@mail.gmail.com>
	<20170914201853.GC23492@localhost.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 14 Sep 2017 22:21:11 +0200
Message-ID: <CALAZnb2Q9WyJ+H6hdai8V-em=rV3rdVViyqqpMkyZ7K-Fw86ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 06/13] qemu.py: make sure we only remove
 files we create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Daniel Berrange <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On Thu, Sep 14, 2017 at 10:18 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, Sep 14, 2017 at 10:05:50PM +0200, Amador Pahim wrote:
>> On Thu, Sep 14, 2017 at 9:46 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> > On Thu, Sep 14, 2017 at 09:38:13PM +0200, Amador Pahim wrote:
>> >> On Tue, Sep 5, 2017 at 5:18 AM, Fam Zheng <famz@redhat.com> wrote:
>> >> > On Fri, 09/01 13:28, Amador Pahim wrote:
> [...]
>> >> >> +        else:
>> >> >> +            if not isinstance(self._monitor_address, tuple):
>> >> >> +                self._created_files.append(self._monitor_address)
>> >> >> +
>> >> >> +        try:
>> >> >> +            flags = os.O_CREAT | os.O_EXCL | os.O_WRONLY
>> >> >> +            os.open(self._qemu_log_path, flags)
>> >> >
>> >> > Why change to os.open() instead of open()?
>> >>
>> >> I want to create the file only if it does not exist. The open() flag
>> >> 'x' is available only in python 3.3. For python <3.3, we need the
>> >> os.open() to have that feature.
>> >
>> > I'm not sure this extra complexity is really necessary.  We could
>> > fix all that by using mkdtemp() and deleting the temporary
>> > directory on shutdown.
>>
>> I thought about that, but I foresee the question: hat happens if
>> between the mkdtemp and the file creation (i.e. self._qemu_log_path)
>> someone goes in that directory and creates a file with the same name
>> of the self._qemu_log_path? Are we going to overwrite it? Ok, very
>> unlikely, but possible. This extra step takes care of that.
>
> If someone creates a file inside a directory we created using
> mkdtemp(), we will just delete it.  Why would that be a problem?

Ok then. That simplifies the control a lot.
Thanks.

>
> --
> Eduardo
