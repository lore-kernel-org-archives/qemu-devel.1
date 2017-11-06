Received: from eggs.gnu.org ([2001:4830:134:3::10]:57914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBjRv-0002TP-OE
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:36:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBjRr-00040R-Q6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:36:31 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:50880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBjRr-000403-JI
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:36:27 -0500
Received: by mail-wr0-f172.google.com with SMTP id p96so8985198wrb.7
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 07:36:27 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20171106142941.2a555646@bahia>
	<2a46b5d63f9ebdf6041cd95041ffa637.squirrel@mifritscher.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ce9c4dc-366f-dc22-d392-6dc4a8675065@redhat.com>
Date: Mon, 6 Nov 2017 16:36:23 +0100
MIME-Version: 1.0
In-Reply-To: <2a46b5d63f9ebdf6041cd95041ffa637.squirrel@mifritscher.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, Greg Kurz <groug@kaod.org>
Cc: mst@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org, aneesh.kumar@linux.vnet.ibm.com, Greg Kurz <gkurz@linux.vnet.ibm.com>

On 06/11/2017 16:14, Michael Fritscher wrote:
> The main thing was the question whether to make a sort of "hack" to
> emulate the *at commands (which is the way used by the patch, the main
> idea using /proc/<pid>/fd information) or make a 9pfs_local_windows
> variant which uses the native ntdll api. Which is ... another style of
> codeing, let me say it this way...

Yeah, that's expected.

> To get an idea I've attached the "main" code with my experiments to open
> the directory. The main question is: Is this kind of code ok? Sadly it
> seems the only way to access the ntdll's function, which in turn is the
> only way to have *at aquivalents.

Just one note, it's probably better to use UTF-8 for the codepage instead
of CP_ACP:

    MultiByteToWideChar(CP_ACP, 0, relative, -1, filename_WIDECHAR, sizeof(filename_WIDECHAR));
    RtlInitUnicodeStringStruct(&filename_UNICODE, filename_WIDECHAR);

> Yes, the code is a bit dirty (very WIP). Additionally, I seem to destroy
> the stack, because after running this function qemu exists. Fixing this is
> my next step.

For what it's worth, the Wine code for kernel32 (see
https://github.com/wine-mirror/wine/blob/master/dlls/kernel32/file.c)
might be of some help.

> NT_OPEN_FILE NtOpenFileStruct;

Better:

static NT_OPEN_FILE p_NtOpenFile;

Paolo

> 
> Best regards,
> Michael Fritscher
> 
