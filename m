Received: from eggs.gnu.org ([2001:4830:134:3::10]:51874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dygw6-00031m-9S
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 12:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dygw3-0001oz-0J
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 12:17:46 -0400
Received: from mifritscher.de ([188.40.170.105]:42980
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dygw2-0001nr-MR
	for qemu-devel@nongnu.org; Sun, 01 Oct 2017 12:17:42 -0400
Message-ID: <115676c417f5f845c436129e6b2be43f.squirrel@mifritscher.de>
In-Reply-To: <497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
	<497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
Date: Sun, 1 Oct 2017 18:17:38 +0200
From: "Michael Fritscher" <michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Hi,

I've no fear to NT API :-D

surprisingly I'm the first guy which try to import things from ntdll it
seems.

I've a working PoC, which can open a directory successfully - see below.
Will code like this ever by acceptable for merging? Else: other ideas? :-=
)
And should I follow this way or try to emulate the relative path thing
myself? Your choose :-)

Best regards,
Michael Fritscher

-----------------------

    //Main info sources:
http://resources.infosecinstitute.com/calling-ntdll-functions-directly/
&
https://googleprojectzero.blogspot.de/2016/02/the-definitive-guide-on-win=
32-to-nt.html
    error_printf("Try to open %s\n", ctx->fs_root);

    typedef NTSTATUS  (__stdcall *NT_OPEN_FILE)(_Out_ PHANDLE FileHandle,
_In_ ACCESS_MASK DesiredAccess, IN POBJECT_ATTRIBUTES
ObjectAttributes, _Out_ PIO_STATUS_BLOCK IoStatusBlock, _In_ ULONG
ShareAccess, _In_ ULONG OpenOptions);
    NT_OPEN_FILE NtOpenFileStruct;

    typedef NTSTATUS (__stdcall
*RTL_ANSI_STRING_TO_UNICODE_STRING)(_Inout_ PUNICODE_STRING
DestinationString, _In_ PCANSI_STRING SourceString, _In_ BOOLEAN
AllocateDestinationString);
    RTL_ANSI_STRING_TO_UNICODE_STRING RtlAnsiStringToUnicodeStringStruct;

    // typedef BOOLEAN (__stdcall
*RTL_DOS_PATH_NAME_TO_RELATIVE_NT_PATH_NAME_U)(_In_ PCWSTR
DosFileName, _Out_ PUNICODE_STRING NtFileName, _Out_opt_  PWSTR*
FilePath, _Out_opt_ PRTL_RELATIVE_NAME RelativeName);
    // RTL_DOS_PATH_NAME_TO_RELATIVE_NT_PATH_NAME_U
RtlDosPathNameToRelativeNtPathName_U;

    //TODO: PRTL_RELATIVE_NAME_U
    typedef BOOLEAN (__stdcall
*RTL_DOS_PATH_NAME_TO_NT_PATH_NAME_U)(_In_opt_z_ PCWSTR DosPathName,
_Out_ PUNICODE_STRING NtPathName, _Out_opt_ PCWSTR * NtFileNamePart,
_Out_opt_ PVOID DirectoryInfo);
    RTL_DOS_PATH_NAME_TO_NT_PATH_NAME_U RtlDosPathNameToNtPathName_UStruc=
t;

    typedef VOID (__stdcall *RTL_FREE_UNICODE_STRING)(_Inout_
PUNICODE_STRING UnicodeString);
    RTL_FREE_UNICODE_STRING RtlFreeUnicodeStringStruct;

    /* load the ntdll.dll */
    HMODULE hModule =3D LoadLibrary("ntdll.dll");

    NtOpenFileStruct =3D (NT_OPEN_FILE)GetProcAddress(hModule, "NtOpenFil=
e");
    if(NtOpenFileStruct =3D=3D NULL) {
        error_printf("Error: could not find the function NtOpenFile in
library ntdll.dll.");
        exit(-1);
    }
    error_printf("NtOpenFile is located at 0x%p in ntdll.dll.\n",
NtOpenFileStruct);

    RtlAnsiStringToUnicodeStringStruct =3D
(RTL_ANSI_STRING_TO_UNICODE_STRING)GetProcAddress(hModule,
"RtlAnsiStringToUnicodeString");
    if(RtlAnsiStringToUnicodeStringStruct =3D=3D NULL) {
        error_printf("Error: could not find the function
RtlAnsiStringToUnicodeString in library ntdll.dll.");
        exit(-1);
    }

    RtlDosPathNameToNtPathName_UStruct =3D
(RTL_DOS_PATH_NAME_TO_NT_PATH_NAME_U)GetProcAddress(hModule,
"RtlDosPathNameToNtPathName_U");
    if(RtlDosPathNameToNtPathName_UStruct =3D=3D NULL) {
        error_printf("Error: could not find the function
RtlAnsiStringToUnicodeString in library ntdll.dll.");
        exit(-1);
    }

    RtlFreeUnicodeStringStruct =3D
(RTL_FREE_UNICODE_STRING)GetProcAddress(hModule,
"RtlFreeUnicodeString");
    if(RtlFreeUnicodeStringStruct =3D=3D NULL) {
        error_printf("Error: could not find the function RtlInitAnsiStrin=
g
in library ntdll.dll.");
        exit(-1);
    }

    /* create the string in the right format */
    UNICODE_STRING filename_UNICODE;

    wchar_t filename_WIDECHAR[4096];

    MultiByteToWideChar(CP_ACP, 0, ctx->fs_root, -1, filename_WIDECHAR,
sizeof(filename_WIDECHAR));
    RtlDosPathNameToNtPathName_UStruct(filename_WIDECHAR,
&filename_UNICODE, NULL, NULL);

    /* initialize OBJECT_ATTRIBUTES */
    OBJECT_ATTRIBUTES obja;
    InitializeObjectAttributes(&obja, &filename_UNICODE,
OBJ_CASE_INSENSITIVE, NULL, NULL);

    /* call NtOpenFile */
    HANDLE file =3D NULL;
    ULONG shareAccess =3D 0;
    ULONG openOptions =3D FILE_DIRECTORY_FILE;
    IO_STATUS_BLOCK statusBlock;
    NTSTATUS stat =3D NtOpenFileStruct(&file, GENERIC_READ |
FILE_READ_ATTRIBUTES, &obja, &statusBlock, shareAccess, openOptions);
    if(NT_SUCCESS(stat)) {
        error_printf("File successfully opened.\n");
    }
    else {
        error_printf("File could not be opened: %lx.\n", stat);
    }
