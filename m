Received: from eggs.gnu.org ([209.51.188.92]:49156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1h0kTI-0003T1-Ff
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1h0kTF-0008U5-Fk
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:05:19 -0500
Received: from greensocs.com ([193.104.36.180]:41690)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1h0kTE-0008Pq-M5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:05:17 -0500
References: <20190304073936.55294-1-lucienmp_antispam@yahoo.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <9e398078-1be1-dbcf-a164-2472ecb94155@greensocs.com>
Date: Mon, 4 Mar 2019 11:05:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190304073936.55294-1-lucienmp_antispam@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Eric Blake <eblake@redhat.com>

Hi Lucien,

When you do a re-roll of your patch, you should:
  - Send it as a new thread (don't reply to an existing one)
  - Add the re-roll count ([PATCH vX] in the subject, easily done using
the -v option of git format-patch).

On 3/4/19 8:39 AM, Lucien Murray-Pitts wrote:
> This fixes a regression in rsp packet vCont, this was due to the
> recently added multiprocess support. (Short commit hash: e40e520).
>=20
> The result is that vCont now does not recognise the case where
> no process/thread is provided after the action.
>=20
> This may not show up with GDB, but using Lauterbach Trace32,
> and Hexrays IDA Pro this issue is immediately seen.
>=20
> The response is a "$#00" empty packet, showing it is unsupported packet=
.
>=20
> This is defined in the RSP document as "An action with no thread-id
> matches all threads."
> (https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#vCont-p=
acket)
>=20
> This is where the document lacks details. It says that the vCont packet
> is used to "Resume the inferior, specifying different actions for each
> thread."
>=20
> So it seems to target only one inferior (i.e. one process).
>=20
> When multiprocess extension is in use, this packet must be supported,
> and used in place of 'Hc' (which modifies s->c_cpu) and other action
> packets (s, S, ...) which are deprecated.
>=20
> So the question is: when the vCont packet does not specifies a
> thread-id, what _process_ we should choose?
>=20
> Going for all process is probably ok because:
>   - we don't have to bother choosing a PID,
>   - it will cover the mono-process case correctly (main use-case of thi=
s
> form of vCont packet I think).
Huum this looks like a copy/paste of my text. That's ok but I would have
appreciated an acknowledgment.

>=20
> The alternative would be can go for GDB_ALL_THREAD and take the PID of =
the
> first attached CPU.  But may lead to problems, so I have chosen the
> GDB_ALL_PROCESSES.>
> A request for improved documentation has been made at;
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D24177
That's nice!

>=20
> Thus, for now, the valid vCont packets now are as below.
> However, parsing is still not very strict and many other invalid argume=
nts
> formats are possible but they are not expected from standard debuggers.
I'm not sure what you mean by "invalid" here. From the protocol PoV, the
syntax is valid. If the first action applies to all processes/threads,
then the next actions will simply have no effect.

If you agree with me then I suggest that you remove those examples below
to avoid confusions.
>=20
>  * vCont;c/s
>  ** Step/Continue all threads
>=20
>  * vCont;c/s:[pX.]Y
>  ** Step/Continue optional process X, thread Y
>=20
>  * vCont;C##/S##:[pX.]Y
>  ** Step/Continue with signal ## on optional process X, thread Y
>=20
>  * If X or Y are -1 then it applies the action to all processes/threads=
.
>=20
> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
> ---
> Third attempt, taking greatly valued input on formatting.
> Also includes a change to the way kind is handled for no-action vcont
> ---
>  gdbstub.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index a4be63f6eb..f8680f7ee8 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1145,6 +1145,7 @@ static int is_query_packet(const char *p, const c=
har *query, char separator)
>   */
>  static int gdb_handle_vcont(GDBState *s, const char *p)
>  {
> +    GDBThreadIdKind kind;
>      int res, signal =3D 0;
>      char cur_action;
>      char *newstates;
> @@ -1194,12 +1195,24 @@ static int gdb_handle_vcont(GDBState *s, const =
char *p)
>              goto out;
>          }
> =20
> -        if (*p++ !=3D ':') {
> +        /*
> +         * When we have vCont;c or vCont;s - action is on all threads
> +         * Alternatively action maybe followed by a ';' and more speci=
fiers
> +         * such as vCont;c;s:p1.1 is a possible, but meaningless forma=
t.
> +         * Otherwise if the action is followed by a ':' then
> +         * the pPID.TID format is expected (for example "vCont;c:p1.1;=
...).
> +         */
Same as my comment above, maybe you can remove this comment, and add
some precisions to your comment bellow:
> +        if (*p =3D=3D '\0' || *p =3D=3D ';') {> +            /* unclea=
r behavior in RSP spec, assume GDB_ALL_PROCESSES
is ok */
  /* No thread specifier, action is on "all threads". The specification
   * is unclear regarding the process to act on. We choose all
   * processes.
   */
> +            kind =3D GDB_ALL_PROCESSES;
> +        } else if (*p++ =3D=3D ':') {
> +            kind =3D read_thread_id(p, &p, &pid, &tid);
> +        } else {
>              res =3D -ENOTSUP;
>              goto out;
>          }
> =20
> -        switch (read_thread_id(p, &p, &pid, &tid)) {
> +        switch (kind) {
>          case GDB_READ_THREAD_ERR:
>              res =3D -EINVAL;
>              goto out;
>=20

With those changes:
Reviewed-by: Luc Michel <luc.michel@greensocs.com>

Thanks,
Luc
