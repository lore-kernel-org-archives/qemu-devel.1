Received: from eggs.gnu.org ([2001:4830:134:3::10]:49249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cRm1X-0007Fz-Kk
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cRm1W-000210-OB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:31:03 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>) id 1cRm1W-00020u-Jd
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:31:02 -0500
Received: by mail-oi0-x241.google.com with SMTP id j15so4464486oih.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 12:31:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112030148.GC26504@lemon>
References: <20170111182455.15160-1-nirsof@gmail.com>
	<750c2d41-dac2-61f7-29c3-82d8d13a0de6@redhat.com>
	<20170112030148.GC26504@lemon>
From: Nir Soffer <nirsof@gmail.com>
Date: Thu, 12 Jan 2017 22:04:11 +0200
Message-ID: <CAMr-obsOnLgMn+XQHzHSTiHVdQj4wAfJHtbN1zmom_ox7R-G0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qemu-io: Return non-zero exit code on
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Nir Soffer <nsoffer@redhat.com>, qemu-devel@nongnu.org

On Thu, Jan 12, 2017 at 5:01 AM, Fam Zheng <famz@redhat.com> wrote:
> On Wed, 01/11 15:51, Eric Blake wrote:
>> On 01/11/2017 12:24 PM, Nir Soffer wrote:
>> > From: Nir Soffer <nsoffer@redhat.com>
>> >
>> > The result of openfile was not checked, leading to failure deep in the
>> > actual command with confusing error message, and exiting with exit code 0.
>> >
>> > Here is one example - trying to read a pattern from an invalid chain:
>> >
>> >     $ qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?
>>
>> As written, you have to guess some context about how top.qcow2 was
>> created.  The example can be made a bit more reproducible with:
>>
>> $ : > file
>> $ qemu-io -f qcow2 -c ... file
>
> Nir, thank you for the fix. Could you also add a regression test in
> tests/qemu-iotests?

Sure, will look into it.

>
> Reviewed-by: Fam Zheng <famz@redhat.com>
>
>>
>> >     can't open device top.qcow2: Could not open backing file: Image is not in qcow2 format
>> >     no file open, try 'help open'
>> >     0
>> >
>> > With this patch, we fail earlier with exit code 1:
>> >
>> >     $ ./qemu-io -c 'read -P 1 0 1024' top.qcow2; echo $?
>> >     can't open device top.qcow2: Could not open backing file: Image is not
>> >     in qcow2 format
>> >     1
>> >
>> > Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> > ---
>> >  qemu-io.c | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> Whether or not the commit message is improved,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
