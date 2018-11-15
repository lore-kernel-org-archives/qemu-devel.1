Received: from eggs.gnu.org ([2001:4830:134:3::10]:48643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNQGu-0008Rh-OV
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNQGq-00059D-RF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:38:00 -0500
References: <20181115215449.1300769-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b600b483-0e46-5c2e-f52b-2f330ebaa5a7@redhat.com>
Date: Thu, 15 Nov 2018 16:37:36 -0600
MIME-Version: 1.0
In-Reply-To: <20181115215449.1300769-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi: Reduce Makefile boilerplate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com, xiezhide@huawei.com, Paolo Bonzini <pbonzini@redhat.com>

On 11/15/18 3:54 PM, Eric Blake wrote:
> Adding a new qapi module had some rather tedious repetition to
> wire it into Makefile. Add some indirection by taking advantage
> of GNU Make string processing to expand a list of module names
> into all the required artifacts, so that future additions of a
> new module need only touch the list of module names.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> I finally found time to follow through with my threats to make it
> MUCH easier to add a new qapi/FOO.json file.
> 
> Should be no semantic change, but as it is not fixing an actual
> bug, I don't care if it goes in 3.1 or 4.0.
> 
>   Makefile | 194 +++++++------------------------------------------------
>   1 file changed, 25 insertions(+), 169 deletions(-)

I'm trying to do the same thing to Makefile.objs, but when I use:

common-obj-y += $(QAPI_MODULES:%=qapi/qapi-commands-%.o)

or the longer $(patsubst %,qapi,qapi-commands-%.o,$(QAPI_MODULES))

both before and after the change, 'make print-common-obj-y | grep qapi' 
returns identical content, but after the change, the linker fails with:

   LINK    x86_64-softmmu/qemu-system-x86_64
monitor.o: In function `monitor_init_qmp_commands':
/home/eblake/qemu/monitor.c:1200: undefined reference to 
`qmp_marshal_qmp_capabilities'
monitor.o: In function `qmp_greeting':
/home/eblake/qemu/monitor.c:4342: undefined reference to 
`qmp_marshal_query_version'
../qapi/qapi-commands.o: In function `qmp_init_marshal':
/home/eblake/qemu/qapi/qapi-commands.c:30: undefined reference to 
`qmp_marshal_query_status'
...

So something about variable expansions is NOT playing nicely with our

dummy := $(call unnest-vars,, \
                 stub-obj-y \
                 chardev-obj-y \
...
                 common-obj-y \

that builds up the set of files the linker needs to see.  But I have 
_no_ idea what is going wrong that makes unnest-vars unable to see 
through a variable expansion of .o files.  Ideas on how to compress 
Makefile.objs to avoid the redundancy would be appreciated.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
