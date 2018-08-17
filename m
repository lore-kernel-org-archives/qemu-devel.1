Received: from eggs.gnu.org ([2001:4830:134:3::10]:33215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqlqg-0006zD-NX
	for Qemu-devel@nongnu.org; Fri, 17 Aug 2018 17:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqlqW-0001g4-TM
	for Qemu-devel@nongnu.org; Fri, 17 Aug 2018 16:59:54 -0400
References: <20180730212249.16418-1-programmingkidx@gmail.com>
	<5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
	<f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
	<20180814084047.GD5025@dhcp-200-186.str.redhat.com>
	<D08F395C-E55A-4FF1-9844-02B606FDDF8E@gmail.com>
	<c1f8aba9-4a63-4dfa-cf0b-9521c869c9ff@redhat.com>
	<D1319041-4F97-49CD-A53C-BFFA6D39BC16@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a924155b-0302-8e3f-395c-3504b8d6f729@redhat.com>
Date: Fri, 17 Aug 2018 15:59:40 -0500
MIME-Version: 1.0
In-Reply-To: <D1319041-4F97-49CD-A53C-BFFA6D39BC16@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between
 commands in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Qemu-devel@nongnu.org

On 08/17/2018 02:28 PM, Programmingkid wrote:

>>>   -o             Used with a comma separated list of format specific options in a
>>>                  name=value format. Use "-o ?" for an overview of the options
>>
>> Please spell that "-o help", not "-o ?".   Otherwise, the user has to quote the ? to avoid it globbing into any single-byte file lying around in the current directory.
> 
> "-o ?" and "-o help" does not appear to work for this command. Maybe it should be removed.
> This is what I tried:
> 	qemu-img amend -o help
> 	qemu-img amend -o ?

The set of options depends on the file format being amended.  So, you 
have to try:

qemu-img amend -o help -f qcow2

or supply an image name, as in:

qemu-img amend -o help myimage.qcow2

(of course, the latter relies on image probing, which I just said is 
potentially unsafe if you didn't use -f).  But the point is the option 
-o does work, just not in isolation.


>>>   -t             Specifies the cache mode that should be used with the
>>>                  destination file.
>>
>> And what are those modes?  If you're going to be wordy, then give the user enough information to be useful.  Otherwise, being terse in --help is fine (and let the man page be wordy instead).
> 
> I don't know what the modes are. Anyone care to fill us in?

The source code is your friend. qemu-img.c has:

        case 'T':
             cache = optarg;
...
     ret = bdrv_parse_cache_mode(cache, &flags, &writethrough);

then you search for bdrv_parse_cache_mode(), in block.c:

     if (!strcmp(mode, "off") || !strcmp(mode, "none")) {
         *writethrough = false;
         *flags |= BDRV_O_NOCACHE;
     } else if (!strcmp(mode, "directsync")) {
         *writethrough = true;
         *flags |= BDRV_O_NOCACHE;
     } else if (!strcmp(mode, "writeback")) {
         *writethrough = false;
     } else if (!strcmp(mode, "unsafe")) {
         *writethrough = false;
         *flags |= BDRV_O_NO_FLUSH;
     } else if (!strcmp(mode, "writethrough")) {
         *writethrough = true;

So six different aliases, for five different modes.  We can either 
improve --help output to document these directly, or add a '-t help' 
option (the way we have '-o help') to dynamically print the list.

> 
> 
>>> Example:
>>>      qemu-img amend -o compat=0.10 -f qcow2 image.qcow2
>>
>> Where's an example with --image-opts and --object secret?
> 
> I prefer examples that I think a user would actually use. The --image-opts and -object options are not necessary to use this command.

Umm, they ARE necessary if you want to amend a LUKS-encrypted image, and 
that IS something I would actually use.  What's more, it's the complex 
examples (like a LUKS-encrypted image) where seeing something spelled 
out will save a LOT of hair-pulling from someone reading the docs (but, 
alongside it should ALSO be a short-and-simple example).

> 
>> We're trying to move away from compat=0.10 (also spelled compat=v2), and instead start encouraging compat=v3.
> 
> So you want this: qemu-img amend -o compat=v3 -f qcow2 image.qcow2

Yes, that's one reasonable example, but should not be the only example.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
