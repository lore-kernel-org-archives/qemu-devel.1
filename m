Received: from eggs.gnu.org ([2001:4830:134:3::10]:53257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egDgd-0001sX-8l
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1egDgZ-0006wg-6E
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:57:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1egDgY-0006wI-T0
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:57:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0THtWA2131647
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:57:37 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ft89k8gku-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:57:36 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 29 Jan 2018 10:57:36 -0700
References: <20180129123227.15778-1-marcandre.lureau@redhat.com>
	<3c1355ed-57af-d023-8da3-21f1600ee018@linux.vnet.ibm.com>
	<CAMxuvaytO_73rzEGduvD6AeT==B-=D-WsmDt5XgeaueQ_uds-A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 29 Jan 2018 12:57:31 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvaytO_73rzEGduvD6AeT==B-=D-WsmDt5XgeaueQ_uds-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <eb97942e-058f-2ba7-301e-9c7950693cd8@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm: fix alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 01/29/2018 12:51 PM, Marc-Andre Lureau wrote:
> Hi
>
> On Mon, Jan 29, 2018 at 6:41 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 01/29/2018 07:32 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> The new tpm-crb-test fails on sparc host:
>>>
>>> TEST: tests/tpm-crb-test... (pid=3D230409)
>>>     /i386/tpm-crb/test:
>>> Broken pipe
>>> FAIL
>>> GTester: last random seed: R02S29cea50247fe1efa59ee885a26d51a85
>>> (pid=3D230423)
>>> FAIL: tests/tpm-crb-test
>>>
>>> and generates a new clang sanitizer runtime warning:
>>>
>>> /home/petmay01/linaro/qemu-for-merges/hw/tpm/tpm_util.h:36:24: runtim=
e
>>> error: load of misaligned address 0x7fdc24c00002 for type 'const
>>> uint32_t' (aka 'const unsigned int'), which requires 4 byte alignment
>>> 0x7fdc24c00002: note: pointer points here
>>> <memory cannot be printed>
>>>
>>> The sparc architecture does not allow misaligned loads and will
>>> segfault if you try them.  For example, this function:
>>>
>>> static inline uint32_t tpm_cmd_get_size(const void *b)
>>> {
>>>       return be32_to_cpu(*(const uint32_t *)(b + 2));
>>> }
>>>
>>> Should read,
>>>       return ldl_be_p(b + 2);
>>>
>>> As a general rule you can't take an arbitrary pointer into a byte
>>> buffer and try to interpret it as a structure or a pointer to a
>>> larger-than-bytesize-data simply by casting the pointer.
>>>
>>> Use this clean up as an opportunity to remove unnecessary temporary
>>> buffers and casts.
>>>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/tpm/tpm_util.h        | 17 ++++++++++-
>>>    hw/tpm/tpm_emulator.c    | 14 ++++-----
>>>    hw/tpm/tpm_passthrough.c |  6 ++--
>>>    hw/tpm/tpm_util.c        | 75
>>> ++++++++++++++++++++++--------------------------
>>>    4 files changed, 58 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
>>> index 19b28474ae..c562140e52 100644
>>> --- a/hw/tpm/tpm_util.h
>>> +++ b/hw/tpm/tpm_util.h
>>> @@ -31,9 +31,24 @@ bool tpm_util_is_selftest(const uint8_t *in, uint3=
2_t
>>> in_len);
>>>
>>>    int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
>>>
>>> +static inline uint16_t tpm_cmd_get_tag(const void *b)
>>> +{
>>> +    return lduw_be_p(b);;
>>> +}
>>> +
>>>    static inline uint32_t tpm_cmd_get_size(const void *b)
>>>    {
>>> -    return be32_to_cpu(*(const uint32_t *)(b + 2));
>>> +    return ldl_be_p(b + 2);;
>>
>> Why are there these two ';;' ?
>>
> obvious typo (repeated..)
>
>>> +}
>>> +
>>> +static inline uint32_t tpm_cmd_get_ordinal(const void *b)
>>> +{
>>> +    return ldl_be_p(b + 6);;
>>> +}
>>> +
>>> +static inline uint32_t tpm_cmd_get_errcode(const void *b)
>>> +{
>>> +    return ldl_be_p(b + 6);;
>>>    }
>>>
>>>    int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
>>> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
>>> index 35c78de5a9..a34a18ac7a 100644
>>> --- a/hw/tpm/tpm_emulator.c
>>> +++ b/hw/tpm/tpm_emulator.c
>>> @@ -120,7 +120,6 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator
>>> *tpm_emu,
>>>    {
>>>        ssize_t ret;
>>>        bool is_selftest =3D false;
>>> -    const struct tpm_resp_hdr *hdr =3D NULL;
>>>
>>>        if (selftest_done) {
>>>            *selftest_done =3D false;
>>> @@ -132,22 +131,21 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulato=
r
>>> *tpm_emu,
>>>            return -1;
>>>        }
>>>
>>> -    ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
>>> sizeof(*hdr),
>>> -                               err);
>>> +    ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
>>> +              sizeof(struct tpm_resp_hdr), err);
>>>        if (ret !=3D 0) {
>>>            return -1;
>>>        }
>>>
>>> -    hdr =3D (struct tpm_resp_hdr *)out;
>>> -    out +=3D sizeof(*hdr);
>>> -    ret =3D qio_channel_read_all(tpm_emu->data_ioc, (char *)out,
>>> -                               be32_to_cpu(hdr->len) - sizeof(*hdr) =
,
>>> err);
>>> +    ret =3D qio_channel_read_all(tpm_emu->data_ioc,
>>> +              (char *)out + sizeof(struct tpm_resp_hdr),
>>> +              tpm_cmd_get_size(out) - sizeof(struct tpm_resp_hdr), e=
rr);
>>>        if (ret !=3D 0) {
>>>            return -1;
>>>        }
>>>
>>>        if (is_selftest) {
>>> -        *selftest_done =3D (be32_to_cpu(hdr->errcode) =3D=3D 0);
>>> +        *selftest_done =3D tpm_cmd_get_errcode(out) =3D=3D 0;
>>>        }
>>>
>>>        return 0;
>>> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
>>> index 29142f38bb..537e11a3f9 100644
>>> --- a/hw/tpm/tpm_passthrough.c
>>> +++ b/hw/tpm/tpm_passthrough.c
>>> @@ -87,7 +87,6 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthru=
State
>>> *tpm_pt,
>>>    {
>>>        ssize_t ret;
>>>        bool is_selftest;
>>> -    const struct tpm_resp_hdr *hdr;
>>>
>>>        /* FIXME: protect shared variables or use other sync mechanism=
 */
>>>        tpm_pt->tpm_op_canceled =3D false;
>>> @@ -116,15 +115,14 @@ static int
>>> tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
>>>                             strerror(errno), errno);
>>>            }
>>>        } else if (ret < sizeof(struct tpm_resp_hdr) ||
>>> -               be32_to_cpu(((struct tpm_resp_hdr *)out)->len) !=3D r=
et) {
>>> +               tpm_cmd_get_size(out) !=3D ret) {
>>>            ret =3D -1;
>>>            error_report("tpm_passthrough: received invalid response "
>>>                         "packet from TPM");
>>>        }
>>>
>>>        if (is_selftest && (ret >=3D sizeof(struct tpm_resp_hdr))) {
>>> -        hdr =3D (struct tpm_resp_hdr *)out;
>>> -        *selftest_done =3D (be32_to_cpu(hdr->errcode) =3D=3D 0);
>>> +        *selftest_done =3D tpm_cmd_get_errcode(out) =3D=3D 0;
>>>        }
>>>
>>>    err_exit:
>>> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
>>> index 747075e244..8abde59915 100644
>>> --- a/hw/tpm/tpm_util.c
>>> +++ b/hw/tpm/tpm_util.c
>>> @@ -106,20 +106,16 @@ const PropertyInfo qdev_prop_tpm =3D {
>>>    void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t ou=
t_len)
>>>    {
>>>        if (out_len >=3D sizeof(struct tpm_resp_hdr)) {
>>> -        struct tpm_resp_hdr *resp =3D (struct tpm_resp_hdr *)out;
>>> -
>>> -        resp->tag =3D cpu_to_be16(TPM_TAG_RSP_COMMAND);
>>> -        resp->len =3D cpu_to_be32(sizeof(struct tpm_resp_hdr));
>>> -        resp->errcode =3D cpu_to_be32(TPM_FAIL);
>>> +        stw_be_p(out, TPM_TAG_RSP_COMMAND);
>>> +        stl_be_p(out + 2, sizeof(struct tpm_resp_hdr));
>>> +        stl_be_p(out + 6, TPM_FAIL);
>>
>> Since we wrapped the getters we should wrap the setters as well.
>> tpm_cmd_set_len(), tpm_cmd_set_errcode.
> They were not as widely used (there was only a getter so far), but
> that makes sense too. Could be done on top.

Also please rebase on top of your series of patches. I had some problems=20
with tpm_passthrough.c around line 115. Error reporting there has changed.
