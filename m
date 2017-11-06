Received: from eggs.gnu.org ([2001:4830:134:3::10]:50383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1eBj6x-0001C3-6C
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1eBj6s-00025m-Pq
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:14:51 -0500
Received: from mifritscher.de ([188.40.170.105]:39904
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1eBj6s-00024h-Ex
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:14:46 -0500
Message-ID: <2a46b5d63f9ebdf6041cd95041ffa637.squirrel@mifritscher.de>
In-Reply-To: <20171106142941.2a555646@bahia>
References: <20170929111323.6308-1-michael@fritscher.net>
	<20171106142941.2a555646@bahia>
Date: Mon, 6 Nov 2017 16:14:43 +0100
From: "Michael Fritscher" <michael@fritscher.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20171106161443_11703"
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Fritscher <michael@fritscher.net>, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>

------=_20171106161443_11703
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

> Sorry for the late reply... Since I have only limited bandwidth, I'll o=
nly
> be able to provide some limited feedback.
No problem!

>
> A global remark to start with: it is a usual practice to prefix each pa=
tch
> title with the component's name, as explained here:
>
> https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit=
_message
>
> eg, patch titles in this series should start with something like with
> fsdev: or
> 9pfs: or oslib-win32:
Yes, I've seen that I forgot this a few minutes too late.


>> this is the patch series to make 9pfs buildable (not working!) on
>> Windows.
>> It is compiling and starts, but obvousily 9pfs is not working - in fac=
t
>> it
>> spits out a initializing error.
>>
>
> What's the error message ?
Sadly I havn't a binary here - it was somthing like "couldn't initialize
the 9pfs". This came only if the cmdline tried to use 9pfs, so it was no
regression. The technical cause was that it tried to use a incompatible
path.

>
> Any updates ? Not sure people will spend time reviewing this series unt=
il
> something actually works.
>

The main thing was the question whether to make a sort of "hack" to
emulate the *at commands (which is the way used by the patch, the main
idea using /proc/<pid>/fd information) or make a 9pfs_local_windows
variant which uses the native ntdll api. Which is ... another style of
codeing, let me say it this way...

To get an idea I've attached the "main" code with my experiments to open
the directory. The main question is: Is this kind of code ok? Sadly it
seems the only way to access the ntdll's function, which in turn is the
only way to have *at aquivalents.

Yes, the code is a bit dirty (very WIP). Additionally, I seem to destroy
the stack, because after running this function qemu exists. Fixing this i=
s
my next step.

Best regards,
Michael Fritscher
------=_20171106161443_11703
Content-Type: text/plain; name="9pfs_windows_code.c"
Content-Disposition: attachment; filename="9pfs_windows_code.c"
Content-Transfer-Encoding: quoted-printable

#include <windows.h>
#include <winternl.h>

typedef NTSTATUS  (__stdcall *NT_OPEN_FILE)(_Out_ PHANDLE FileHandle, _In=
_ ACCESS_MASK DesiredAccess, IN POBJECT_ATTRIBUTES ObjectAttributes, _Out=
_ PIO_STATUS_BLOCK IoStatusBlock, _In_ ULONG ShareAccess, _In_ ULONG Open=
Options);
NT_OPEN_FILE NtOpenFileStruct;

// typedef VOID (__stdcall *RTL_INIT_ANSI_STRING)(_Out_ PANSI_STRING Dest=
inationString, _In_opt_ PCSZ SourceString);
// RTL_INIT_ANSI_STRING RtlInitAnsiStringStruct;

// typedef VOID (__stdcall *RTL_INIT_STRING)(_Out_ PSTRING DestinationStr=
ing, _In_opt_ PCSZ SourceString);
// RTL_INIT_STRING RtlInitStringStruct;

typedef NTSTATUS (__stdcall *RTL_ANSI_STRING_TO_UNICODE_STRING)(_Inout_ P=
UNICODE_STRING DestinationString, _In_ PCANSI_STRING SourceString, _In_ B=
OOLEAN AllocateDestinationString);
RTL_ANSI_STRING_TO_UNICODE_STRING RtlAnsiStringToUnicodeStringStruct;

// typedef BOOLEAN (__stdcall *RTL_DOS_PATH_NAME_TO_RELATIVE_NT_PATH_NAME=
_U)(_In_ PCWSTR DosFileName, _Out_ PUNICODE_STRING NtFileName, _Out_opt_ =
 PWSTR* FilePath, _Out_opt_ PRTL_RELATIVE_NAME RelativeName);
// RTL_DOS_PATH_NAME_TO_RELATIVE_NT_PATH_NAME_U RtlDosPathNameToRelativeN=
tPathName_UStruct;

typedef BOOLEAN (__stdcall *RTL_DOS_PATH_NAME_TO_NT_PATH_NAME_U)(_In_opt_=
z_ PCWSTR DosPathName, _Out_ PUNICODE_STRING NtPathName, _Out_opt_ PCWSTR=
 * NtFileNamePart, _Out_opt_ PVOID DirectoryInfo);
RTL_DOS_PATH_NAME_TO_NT_PATH_NAME_U RtlDosPathNameToNtPathName_UStruct;

typedef VOID  (__stdcall *RTL_INIT_UNICODE_STRING)(_Inout_ PUNICODE_STRIN=
G DestinationString, _In_opt_ PCWSTR SourceString);
RTL_INIT_UNICODE_STRING RtlInitUnicodeStringStruct;

typedef VOID (__stdcall *RTL_FREE_UNICODE_STRING)(_Inout_ PUNICODE_STRING=
 UnicodeString);
RTL_FREE_UNICODE_STRING RtlFreeUnicodeStringStruct;

static void local_init_ntdll(void);

static void local_init_ntdll(void)
{
    /* load the ntdll.dll */
    HMODULE hModule =3D LoadLibrary("ntdll.dll");

    NtOpenFileStruct =3D (NT_OPEN_FILE)GetProcAddress(hModule, "NtOpenFil=
e");
    if(NtOpenFileStruct =3D=3D NULL) {
        error_printf("Error: could not find the function NtOpenFile in li=
brary ntdll.dll.");
        exit(-1);
    }
    error_printf("NtOpenFile is located at 0x%p in ntdll.dll.\n", NtOpenF=
ileStruct);

    //RtlInitAnsiStringStruct =3D (RTL_INIT_ANSI_STRING)GetProcAddress(hM=
odule, "RtlInitAnsiString");
    //if(NtOpenFileStruct =3D=3D NULL) {
    //    error_printf("Error: could not find the function RtlInitAnsiStr=
ing in library ntdll.dll.");
    //    exit(-1);
    //}

    //RtlInitStringStruct =3D (RTL_INIT_ANSI_STRING)GetProcAddress(hModul=
e, "RtlInitString");
    //if(NtOpenFileStruct =3D=3D NULL) {
    //    error_printf("Error: could not find the function RtlInitString =
in library ntdll.dll.");
    //    exit(-1);
    //}

    RtlAnsiStringToUnicodeStringStruct =3D (RTL_ANSI_STRING_TO_UNICODE_ST=
RING)GetProcAddress(hModule, "RtlAnsiStringToUnicodeString");
    if(RtlAnsiStringToUnicodeStringStruct =3D=3D NULL) {
        error_printf("Error: could not find the function RtlAnsiStringToU=
nicodeString in library ntdll.dll.");
        exit(-1);
    }

    // RtlDosPathNameToRelativeNtPathName_UStruct =3D (RTL_DOS_PATH_NAME_=
TO_RELATIVE_NT_PATH_NAME_U)GetProcAddress(hModule, "RtlDosPathNameToRelat=
iveNtPathName_U");
    // if(RtlDosPathNameToRelativeNtPathName_UStruct =3D=3D NULL) {
    //     error_printf("Error: could not find the function RtlDosPathNam=
eToRelativeNtPathName in library ntdll.dll.");
    //     exit(-1);
    // }

    RtlDosPathNameToNtPathName_UStruct =3D (RTL_DOS_PATH_NAME_TO_NT_PATH_=
NAME_U)GetProcAddress(hModule, "RtlDosPathNameToNtPathName_U");
    if(RtlDosPathNameToNtPathName_UStruct =3D=3D NULL) {
        error_printf("Error: could not find the function RtlDosPathNameTo=
NtPathName in library ntdll.dll.");
        exit(-1);
    }

    RtlInitUnicodeStringStruct =3D (RTL_INIT_UNICODE_STRING)GetProcAddres=
s(hModule, "RtlInitUnicodeString");
    if(RtlInitUnicodeStringStruct =3D=3D NULL) {
        error_printf("Error: could not find the function RtlInitUnicodeSt=
ring in library ntdll.dll.");
        exit(-1);
    }

    RtlFreeUnicodeStringStruct =3D (RTL_FREE_UNICODE_STRING)GetProcAddres=
s(hModule, "RtlFreeUnicodeString");
    if(RtlFreeUnicodeStringStruct =3D=3D NULL) {
        error_printf("Error: could not find the function RtlFreeUnicodeSt=
ring in library ntdll.dll.");
        exit(-1);
    }

}

static HANDLE local_open_internal(FsContext *fs_ctx, const char* relative=
)
{
    LocalData *data =3D fs_ctx->private;

    error_printf("Try to open %s\n", relative);
	if (relative[0] =3D=3D '.' && relative[1] =3D=3D '\0') {
		return data->mount_handle;
	}

    /* create the string in the right format */
    //STRING filename;
    //ANSI_STRING filename_ANSI;
    UNICODE_STRING filename_UNICODE;

    //RtlInitStringStruct(&filename, ctx->fs_root);

    wchar_t filename_WIDECHAR[4096];

    MultiByteToWideChar(CP_ACP, 0, relative, -1, filename_WIDECHAR, sizeo=
f(filename_WIDECHAR));
    RtlInitUnicodeStringStruct(&filename_UNICODE, filename_WIDECHAR);

    /* initialize OBJECT_ATTRIBUTES */
    OBJECT_ATTRIBUTES obja;
    InitializeObjectAttributes(&obja, &filename_UNICODE, OBJ_CASE_INSENSI=
TIVE, data->mount_handle, NULL);
=20
    /* call NtOpenFile */
    HANDLE file =3D NULL;
    ULONG shareAccess =3D FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE=
_DELETE; //0;
    ULONG openOptions =3D 0; //FILE_NON_DIRECTORY_FILE; //FILE_DIRECTORY_=
FILE;
    IO_STATUS_BLOCK statusBlock;
    NTSTATUS stat =3D NtOpenFileStruct(&file, GENERIC_READ | FILE_READ_AT=
TRIBUTES, &obja, &statusBlock, shareAccess, openOptions);
    if(NT_SUCCESS(stat)) {
        error_printf("File successfully opened.\n");
    }
    else {
        error_printf("File could not be opened: %lx.\n", stat);
    }

    RtlFreeUnicodeStringStruct(&filename_UNICODE);

    return file;
}


static int local_init(FsContext *ctx)
{
#ifdef FS_IOC_GETVERSION
    struct statfs stbuf;
#endif
    LocalData *data =3D g_malloc(sizeof(*data));

    local_init_ntdll();

    //Main info sources: http://resources.infosecinstitute.com/calling-nt=
dll-functions-directly/ & https://googleprojectzero.blogspot.de/2016/02/t=
he-definitive-guide-on-win32-to-nt.html
    error_printf("Try to open %s\n", ctx->fs_root);



    /* create the string in the right format */
    //STRING filename;
    //ANSI_STRING filename_ANSI;
    UNICODE_STRING filename_UNICODE;

    //RtlInitStringStruct(&filename, ctx->fs_root);

    wchar_t filename_WIDECHAR[4096];

    MultiByteToWideChar(CP_ACP, 0, ctx->fs_root, -1, filename_WIDECHAR, s=
izeof(filename_WIDECHAR));
    RtlDosPathNameToNtPathName_UStruct(filename_WIDECHAR, &filename_UNICO=
DE, NULL, NULL);

    /* initialize OBJECT_ATTRIBUTES */
    OBJECT_ATTRIBUTES obja;
    InitializeObjectAttributes(&obja, &filename_UNICODE, OBJ_CASE_INSENSI=
TIVE, NULL, NULL);
=20
    /* call NtOpenFile */
    HANDLE file =3D NULL;
    ULONG shareAccess =3D 0;
    ULONG openOptions =3D FILE_DIRECTORY_FILE;
    IO_STATUS_BLOCK statusBlock;
    NTSTATUS stat =3D NtOpenFileStruct(&file, GENERIC_READ | FILE_READ_AT=
TRIBUTES, &obja, &statusBlock, shareAccess, openOptions);
    if(NT_SUCCESS(stat)) {
        error_printf("File successfully opened.\n");
    }
    else {
        error_printf("File could not be opened: %lx.\n", stat);
        goto err;
    }

    RtlFreeUnicodeStringStruct(&filename_UNICODE);

=09
	// local_open_internal(file, "blah");
	// local_open_internal(file, "blub.txt");
=09

    data->mount_handle =3D file;

    ctx->xops =3D 0;
    ctx->export_flags |=3D V9FS_PATHNAME_FSCONTEXT;

    ctx->private =3D data;
    return 0;

err:
    g_free(data);
    return -1;
}
------=_20171106161443_11703--
